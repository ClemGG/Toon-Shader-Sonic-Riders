// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Toon/Final/Surf"
{
    Properties
    {
        [Header(Base Parameters)]
        _MainTex("Texture", 2D) = "white" {}
        _NormalMap("Normal map", 2D) = "bump" {}
        _Color("Tint", Color) = (1, 1, 1, 1)

        _NormalStrength("Normal Strength", Range(0, 20)) = 1
        _TextureEmissionIntensity("Texture Emission Intensity", float) = 1
        _ShadowEmissionIntensity("Shadow Emission Intensity", float) = 1
        [HDR] _Emission("Emission", color) = (0 ,0 ,0 , 1)





        [Space(20)]
        [Header(Lighting Parameters)]
        [NoScaleOffset] _ShadowTex("Shadow Texture", 2D) = "white" {}
        _ShadowTexSize("Shadow Texture Size", float) = 1
        _ShadowTexRotation("Shadow Texture Rotation", Range(0.0, 360)) = 0
        _ShadowTexTransparencyCoef("Shadow Texture Transparency Coef", Range(0.0, 1.0)) = 1.0

        [Toggle] _UseShadowTex("Use Shadow Texture", float) = 0
        [Toggle] _DrawShadowAsSolidColor("Draw Shadow As Solid Color", float) = 0
        [Toggle] _LightingAffectsShadow("Lighting Affects Shadow", float) = 0
        [Toggle] _LightingAffectsSpecular("Lighting Affects Specular", float) = 0
        [Toggle] _UseRimLighting("Use Rim Lighting", float) = 0

        _ShadowTint("Shadow Color", Color) = (0.5, 0.5, 0.5, 1)
        [IntRange]_StepAmount("Shadow Steps", Range(1, 16)) = 2
        _StepWidth("Step Size", Range(0, 1)) = 0.25

        _SpecularTint("Specular Color", Color) = (1,1,1,1)
        _SpecularSize("Specular Size", Range(0, 1)) = 0.1
        _SpecularFalloff("Specular Falloff", Range(0, 2)) = 1

            
        [HDR] _RimColor("Rim Color", Color) = (1,1,1,1)
        _RimAmount("Rim Amount", Range(0, 1)) = 0.716
        _RimThreshold("Rim Threshold", Range(0, 1)) = 0.1



        [Space(20)]
        [Header(Dithering Parameters)]
        [NoScaleOffset] _DitherPattern("Dithering Pattern", 2D) = "white" {}
        _MinDistance("Minimum Fade Distance", Float) = 0
        _MaxDistance("Maximum Fade Distance", Float) = 1





        [Space(20)]
        [Header(Outline Parameters)]
        [Toggle] _ColorOnly("Color Only", float) = 0
        [Toggle] _UseAnimation("Use Animation", float) = 0

        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineExtrusion("Outline Extrusion", float) = 0
        _OutlineDot("Outline Dot", float) = 0.25
        _OutlineDot2("Outline Dot Distance", float) = 0.5
        _OutlineSpeed("Outline Dot Speed", float) = 50.0

        _SourcePos("Source Position", vector) = (0, 0, 0, 0)


        [Space(20)]
        [Header(Halftone Parameters)]
        [NoScaleOffset] _HalftonePattern("Halftone Pattern", 2D) = "white" {}
        [Toggle] _UseHalftone("Use Halftone", float) = 0
        _HalftoneTexSize("Halftone Texture Size", float) = 1
        _HalftoneTexRotation("Halftone Texture Rotation", Range(0.0, 360)) = 0

        _RemapInputMin("Remap input min value", Range(0, 1)) = 0
        _RemapInputMax("Remap input max value", Range(0, 1)) = 1
        _RemapOutputMin("Remap output min value", Range(0, 1)) = 0
        _RemapOutputMax("Remap output max value", Range(0, 1)) = 1

    }
    SubShader
    {

        // Outline pass
        Pass
        {
            // Won't draw where it sees ref value 4

            //A décommenter si on veut garder l'outline dans le mesh quand le dithering fait effet
            //Ca affiche le material des deux côtés je crois
            //Cull OFF
            ZWrite OFF
            ZTest ON
            Stencil
            {
                Ref 4
                Comp notequal
                Fail keep
                Pass replace
            }



            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"


            //The dithering pattern
            sampler2D _DitherPattern;
            float4 _DitherPattern_TexelSize;

            //remapping of distance
            float _MinDistance;
            float _MaxDistance;




            // Properties
            float _ColorOnly;
            float _UseAnimation;
            uniform float4 _OutlineColor;
            uniform float _OutlineSize;
            uniform float _OutlineExtrusion;
            float  _OutlineDot;
            float  _OutlineDot2;
            float  _OutlineSpeed;
            float4 _SourcePos;

            sampler2D _MainTex;

            //float4 _LightColor0; // provided by Unity
            //float _OutlineLightingAtten;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float3 texCoord : TEXCOORD0;
                float4 color : TEXCOORD1;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 color : TEXCOORD0;
                float4 screenCoord : TEXCOORD1;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;

                float4 newPos = input.vertex;

                // normal extrusion technique
                float3 normal = normalize(input.normal);
                newPos += float4(normal, 0.0) * _OutlineExtrusion;



                // convert to world space
                output.pos = UnityObjectToClipPos(newPos);

                // get screen coordinates
                output.screenCoord = ComputeScreenPos(output.pos);



                output.color = (tex2Dlod(_MainTex, float4(input.texCoord.xy, 0, 0)) + float4(1,1,1,1) * _ColorOnly) * _OutlineColor;


                return output;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                
                // dotted line with animation
                float2 pos = input.pos.xy + _Time * _OutlineSpeed;
                float skip = sin(_OutlineDot * abs(distance(_SourcePos.xy, pos))) + _OutlineDot2;
                clip(skip * _UseAnimation); // stops rendering a pixel if 'skip' is negative
                clip(input.pos.x);

                //value from the dither pattern
                float2 screenPos = input.screenCoord.xy / input.screenCoord.w;
                float2 ditherCoordinate = screenPos * _ScreenParams.xy * _DitherPattern_TexelSize.xy;
                float ditherValue = tex2D(_DitherPattern, ditherCoordinate).r;

                //get relative distance from the camera
                float relDistance = input.screenCoord.w;
                relDistance = relDistance - _MinDistance;
                relDistance = relDistance / (_MaxDistance - _MinDistance);
                //discard pixels accordingly
                clip(relDistance - ditherValue);

                return input.color;
            }

            ENDCG
        }

        //the material is completely non-transparent and is rendered at the same time as the other opaque geometry
        //Si on laisse la Queue à Transparent, la transparence est fidèle mais le shader ne peut plus recevoir d'ombres
        //A l'inverse, si on la laisse en Geometry ou AlphaTest, le shader reçoit les ombres mais également dans les zones transparentes
        //On fera un shader à part pour gérer les ombres
        Tags
        { 
            "RenderType" = "Transparent" 
            "Queue" = "Transparent"

            //Pour restreindre la lumière reçue à uniquement la Directional Light
            //"LightMode" = "ForwardBase"
            //"PassFlags" = "OnlyDirectional"
        }

        CGPROGRAM

        //the shader is a surface shader, meaning that it will be extended by unity in the background to have fancy lighting and other features
        //our surface shader function is called surf and we use our custom lighting model
        //fullforwardshadows makes sure unity adds the shadow passes the shader might need
        #pragma surface surf Stepped fullforwardshadows
        #pragma target 3.0
        
        sampler2D _MainTex;
        sampler2D _NormalMap;

        fixed4 _Color;
        half3 _Emission;
        float _NormalStrength;
        float _TextureEmissionIntensity;
        float _ShadowEmissionIntensity;
        float _UseEmissionColor;


        sampler2D _ShadowTex;

        float _ShadowTexSize;
        float _ShadowTexRotation;
        float _ShadowTexTransparencyCoef;

        float _UseShadowTex;
        float _DrawShadowAsSolidColor;
        float _LightingAffectsShadow;
        float _LightingAffectsSpecular;
        float _UseRimLighting;


        float4 _ShadowTint;
        fixed4 _SpecularTint;
        float _StepWidth;
        float _StepAmount;
        float _SpecularSize;
        float _SpecularFalloff;


        float4 _RimColor;
        float _RimAmount;
        float _RimThreshold;


        //The dithering pattern
        sampler2D _DitherPattern;
        float4 _DitherPattern_TexelSize;

        //remapping of distance
        float _MinDistance;
        float _MaxDistance;
        

        //Halftone

        //shading properties
        sampler2D _HalftonePattern;
        float4 _HalftonePattern_ST;
        float _HalftoneTexSize;
        float _HalftoneTexRotation;

        ///remapping values
        float _UseHalftone;
        float _RemapInputMin;
        float _RemapInputMax;
        float _RemapOutputMin;
        float _RemapOutputMax;


        //input struct which is automatically filled by unity
        struct Input {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float4 screenPos;
        };


        float2 rotateUV(float2 uv, float degrees)
        {
            // rotating UV
            const float Deg2Rad = (UNITY_PI * 2.0) / 360.0;

            float rotationRadians = degrees * Deg2Rad; // convert degrees to radians
            float s = sin(rotationRadians); // sin and cos take radians, not degrees
            float c = cos(rotationRadians);

            float2x2 rotationMatrix = float2x2(c, -s, s, c); // construct simple rotation matrix

            uv -= 0.5; // offset UV so we rotate around 0.5 and not 0.0
            uv = mul(rotationMatrix, uv); // apply rotation matrix
            uv += 0.5; // offset UV again so UVs are in the correct location

            return uv;
        }

        float2 GetScreenUV(float4 clipPos, float UVscaleFactor)
        {
            float2 screenUV = clipPos.xy / clipPos.w;
            screenUV *= 1 / UVscaleFactor;
            float aspect = _ScreenParams.x / _ScreenParams.y;
            screenUV.x = screenUV.x * aspect;

            return screenUV;
        }

        // This function remaps values from a input to a output range
        float map(float input, float inMin, float inMax, float outMin, float outMax)
        {
            //inverse lerp with input range
            float relativeValue = (input - inMin) / (inMax - inMin);
            //lerp with output range
            return lerp(outMin, outMax, relativeValue);
        }

        

        struct ToonSurfaceOutput {
            fixed3 Albedo;
            half3 Emission;
            half Metallic;
            fixed3 Specular;
            fixed Alpha;
            fixed3 Normal;


            float4 ShadowTexColor;
            float2 ScreenPos;
        };

        //our lighting function. Will be called once per light
        float4 LightingStepped(ToonSurfaceOutput s, float3 lightDir, half3 viewDir, float shadowAttenuation) {



            //how much does the normal point towards the light?
            float towardsLight = dot(s.Normal, lightDir);

            //stretch values so each whole value is one step
            towardsLight = towardsLight / _StepWidth;
            //make steps harder
            float lightIntensity = floor(towardsLight);

            // calculate smoothing in first pixels of the steps and add smoothing to step, raising it by one step
            // (that's fine because we used floor previously and we want everything to be the value above the floor value, 
            // for example 0 to 1 should be 1, 1 to 2 should be 2 etc...)
            float change = fwidth(towardsLight);
            float smoothing = smoothstep(0, change, frac(towardsLight));
            lightIntensity = lightIntensity + smoothing;

            // bring the light intensity back into a range where we can use it for color
            // and clamp it so it doesn't do weird stuff below 0 / above one
            lightIntensity = lightIntensity / _StepAmount;
            lightIntensity = saturate(lightIntensity);




        #ifdef USING_DIRECTIONAL_LIGHT
            //for directional lights, get a hard vut in the middle of the shadow attenuation
            float attenuationChange = fwidth(shadowAttenuation) * 0.5;
            float shadow = smoothstep(0.5 - attenuationChange, 0.5 + attenuationChange, shadowAttenuation);
        #else
            //for other light types (point, spot), put the cutoff near black, so the falloff doesn't affect the range
            float attenuationChange = fwidth(shadowAttenuation);
            float shadow = smoothstep(0, attenuationChange, shadowAttenuation);
        #endif
            lightIntensity = lightIntensity * shadow;




            //calculate how much the surface points points towards the reflection direction
            float3 reflectionDirection = reflect(lightDir, s.Normal);
            float towardsReflection = dot(viewDir, -reflectionDirection);

            //make specular highlight all off towards outside of model
            float specularFalloff = dot(viewDir, s.Normal);
            specularFalloff = pow(specularFalloff, _SpecularFalloff);
            towardsReflection = towardsReflection * specularFalloff;

            //make specular intensity with a hard corner
            float specularChange = fwidth(towardsReflection);
            float specularIntensity = smoothstep(1 - _SpecularSize, 1 - _SpecularSize + specularChange, towardsReflection);
            //factor inshadows
            specularIntensity = specularIntensity * shadow;


            //Rim lighting
            float4 rimDot = 1 - dot(viewDir, s.Normal); 
            float rimIntensity = rimDot * pow(towardsLight, _RimThreshold);
            rimIntensity = smoothstep(_RimAmount - 0.01, _RimAmount + 0.01, rimIntensity);
            float4 rim = rimIntensity * _RimColor;





            //Pour le halftone, on recalcule la lumière et on la multiplie par la lightIntensity qu'on avait déjà.
            //Ca ne donne pas exactement le résultat qu'on cherchait, puisque la condition suffisait à obtenir l'halftone,
            //Mais je trouve que c'est plus joli comme ça

            if (_UseHalftone) 
            {

                //how much does the normal point towards the light?
                //remap the value from -1 to 1 to between 0 and 1
                float twdLight = towardsLight * 0.5 + 0.5;
                //combine shadow and light and clamp the result between 0 and 1
                float lightInt = saturate(twdLight * shadowAttenuation).r;

                //get halftone comparison value
                float halftoneValue = tex2D(_HalftonePattern, s.ScreenPos).r;

                //make lightness binary between fully lit and fully shadow based on halftone pattern (with a bit of antialiasing between)
                halftoneValue = map(halftoneValue, _RemapInputMin, _RemapInputMax, _RemapOutputMin, _RemapOutputMax);
                float halftoneChange = fwidth(halftoneValue) * 0.5;
                //lightIntensity = smoothstep(halftoneValue - halftoneChange, halftoneValue + halftoneChange, lightIntensity);
                lightInt = smoothstep(halftoneValue - halftoneChange, halftoneValue + halftoneChange, lightInt);
                lightIntensity = lightIntensity * lightInt;
            }





            //calculate final color
            float4 color;
            float4 inverseColor; 
            float4 shadowTex;    
            float3 shouldLightingAffectShadow = lerp(float3(1, 1, 1), _LightColor0.rgb, _LightingAffectsShadow) * _ShadowTint;
            float3 shouldLightingAffectSpecular = lerp(float3(1, 1, 1), _LightColor0.rgb, _LightingAffectsSpecular) * _SpecularTint;



            //La texture de l'ombre adaptée à l'éclairage
            shadowTex.rgb = s.ShadowTexColor.rgb * _UseShadowTex * (1 - lightIntensity) + (1 - lightIntensity) * (1 - _UseShadowTex);
            shadowTex.rgb = lerp((1 - lightIntensity), shadowTex.rgb, _ShadowTexTransparencyCoef);

            // La couleur de la texture seule + la texture de l'ombre
            //Enlever ce qu'il y a après shadowTex au cas où si jamais on veut que la couleur de l'ombre impacte aussi le côté éclairé
            color.rgb = s.Albedo * lightIntensity * _LightColor0.rgb + shadowTex * shouldLightingAffectShadow * s.Albedo / 2 * (1 - _DrawShadowAsSolidColor);

            
            //L'ombre en couleur solide + la texture de l'ombre inversée
            inverseColor.rgb = (1 - lightIntensity) * shadowTex * shouldLightingAffectShadow;

            color.rgb = lerp(color.rgb, s.Specular * shouldLightingAffectSpecular, saturate(specularIntensity));
            inverseColor.rgb = lerp(inverseColor.rgb, s.Specular * shouldLightingAffectSpecular, saturate(specularIntensity));
            rim.rgb = lerp(float3(0, 0, 0), rim.rgb, _UseRimLighting);


            color.a = s.Alpha;
            inverseColor.a = s.Alpha;
            //On met la rim en négatif pour que la couleur reste bien visible.
            //Par contre, elle est en négatif, donc il faudra inverser sa couleur dans l'inspector.
            //Il y a aussi des artéfacts bizarres au niveau de la couleur mais on s'en contentera
            return color + (inverseColor * _DrawShadowAsSolidColor) - rim;
        }

        

        //the surface shader function which sets parameters the lighting function then uses
        void surf(Input i, inout ToonSurfaceOutput o) {
            
            //Lighting
            
            //sample and tint albedo texture
            fixed4 col = tex2D(_MainTex, i.uv_MainTex);
            col *= _Color;
            o.Albedo = col.rgb;

            o.Specular = _SpecularTint;
            o.Normal = UnpackNormal(tex2D(_NormalMap, i.uv_NormalMap));
            o.Normal.z = _NormalStrength;


            //Shadows

            //Je laisse ça au cas où si jamais on veut que la couleur de l'ombre impacte aussi le côté éclairé
            //float3 shadowColor = col.rgb * _ShadowTint;
            o.Emission = col.rgb * _TextureEmissionIntensity + _Emission;// + shadowColor * (1 - _DrawShadowAsSolidColor);



            float2 screenUV = GetScreenUV(i.screenPos, _ShadowTexSize);
            screenUV = rotateUV(screenUV, _ShadowTexRotation);
            o.ShadowTexColor = tex2D(_ShadowTex, screenUV) * _ShadowEmissionIntensity;

            





            //Dithering

            //value from the dither pattern
            float2 screenPos = i.screenPos.xy / i.screenPos.w;
            float2 ditherCoordinate = screenPos * _ScreenParams.xy * _DitherPattern_TexelSize.xy;
            float ditherValue = tex2D(_DitherPattern, ditherCoordinate).r;

            //get relative distance from the camera
            float relDistance = i.screenPos.w;
            relDistance = relDistance - _MinDistance;
            relDistance = relDistance / (_MaxDistance - _MinDistance);
            //discard pixels accordingly
            clip(relDistance - ditherValue);


            //Halftone

            //setup screenspace UVs for lighting function
            float2 halftoneScreenUV = GetScreenUV(i.screenPos, _HalftoneTexSize);
            halftoneScreenUV = rotateUV(halftoneScreenUV, _HalftoneTexRotation);

            o.ScreenPos = halftoneScreenUV;
            o.ScreenPos = TRANSFORM_TEX(o.ScreenPos, _HalftonePattern);


        }
        ENDCG



    }
    FallBack "Standard"

}