// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'



Shader "Custom/Toon/Final/Frag"
{
	Properties
	{



		[Header(Textures)]
		[Space(20)]

		_MainTex("Texture", 2D) = "white" {}
		[NoScaleOffset] _OcclusionMap("Occlusion Map", 2D) = "white" {}
		[Normal] [NoScaleOffset] _NormalMap("Normal map", 2D) = "bump" {}
		[NoScaleOffset] _MetallicMap("Metallic map", 2D) = "white" {}
		[NoScaleOffset] _GlossMap("Gloss map", 2D) = "white" {}
		[NoScaleOffset] _EmissionMap("Emission Map", 2D) = "white" {}
		_CutoutMap("Cutout Map", 2D) = "white" {}
		[NoScaleOffset] _Cubemap("Cubemap", CUBE) = "" {}

		//Off : Affiche les deux côtés
		//Front : Affiche les faces internes
		//Back : Affiche les faces externes
		[Enum(UnityEngine.Rendering.CullMode)] _MeshCullMode("Mesh Cull Mode", float) = 2










		[Space(20)]
		[Header(Global Parameters)]
		[Space(20)]

		[Toggle] _UseAmbientTint("Use Ambient Tint", float) = 0
		[Toggle] _UseAmbientSkybox("Use Ambient Skybox", float) = 0
		[Toggle] _UseSkyboxRelfection("Use Skybox Relfection", float) = 0	//Les réflexions doivent être paramétrées dans les Light Settings
		[Toggle] _UseEnvironmentalRelfection("Use Environmental Relfection", float) = 0	//Les réflexions doivent être paramétrées dans les Light Settings
		[Toggle] _NormalAffectsReflection("Normal Affects Relfection", float) = 1

		[Space(20)]

		_SkyboxAmbientIntensity("Skybox Ambient Intensity", float) = 1
		_TextureEmissionIntensity("Texture Emission Intensity", float) = 1
		_ShadowEmissionIntensity("Shadow Emission Intensity", float) = 1
		_OcclusionStrength("Occlusion Strength", Range(0, 2)) = 1
		_NormalStrength("Normal Strength", Range(0, 2)) = 0
		_MetallicMapStrength("Metallic Map Strength", Range(0, 1)) = 0
		_GlossMapStrength("Gloss Map Strength", Range(0, 1)) = 0
		_ReflectionIntensity("Reflection Intensity", Range(0, 1)) = 1


		[Space(20)]

		_Cutoff("Cutoff", Range(0, 1)) = 1
		_Alpha("Global Alpha", Range(0, 1)) = 1
		[HDR] _MainTexColor("Main Texture Color", Color) = (1, 1, 1, 1)
		[HDR] _LitSideColor("Lit Side Color", Color) = (1, 1, 1, 1)
		[HDR] _AmbientColor("Ambient Color", Color) = (0.4,0.4,0.4,1)
		[HDR] _Emission("Emission", Color) = (0 ,0 ,0 , 1)














		[Space(20)]
		[Header(Lighting Parameters)]
		[Space(20)]

		[NoScaleOffset] _ShadowTex("Shadow Texture", 2D) = "white" {}
		[Toggle] _UseShadow("Use Shadow", float) = 1
		[Toggle] _UseShadowTex("Use Shadow Texture", float) = 0
		[Toggle] _SeparateNdotlFromReceivedShadows("Use Separate Color For Received Shadows", float) = 0
		[Toggle] _UseShadowTexForReceivedShadows("Use Shadow Texture For Received Shadows", float) = 0

		[Space(20)]

		[Toggle] _UseSpecular("Use Specular", float) = 0
		[Toggle] _UseRimLighting("Use Rim Lighting", float) = 0
		[Toggle] _UseFresnel("Use Fresnel", float) = 0
		[Toggle] _HardFresnel("Hard Fresnel", float) = 0

		[Space(20)]

		[Toggle] _DrawShadowAsSolidColor("Draw Shadow As Solid Color", float) = 0
		[Toggle] _DrawReceivedShadowsAsSolidColor("Draw Received Shadows As Solid Color", float) = 0
		[Toggle] _LightingAffectsShadow("Lighting Affects Shadow", float) = 0
		[Toggle] _ReflectionAffectsShadow("Reflection Affects Shadow", float) = 0
		[Toggle] _LightingAffectsSpecular("Lighting Affects Specular", float) = 0
		[Toggle] _LightingAffectsRim("Lighting Affects Rim", float) = 0
		[Toggle] _TextureAffectsSpecular("Texture Affects Specular", float) = 0
		[Toggle] _TextureAffectsRim("Texture Affects Rim", float) = 0
		[Toggle] _RimReceivesShadows("Rim Receives Shadows", float) = 0
		[Toggle] _TextureAffectsFresnel("Texture Affects Fresnel", float) = 0





		[Space(20)]
		[Header(Lighting Colors)]
		[Space(20)]

		_ShadowTexSize("Shadow Texture Size", float) = 0.1
		_ShadowTexRotation("Shadow Texture Rotation", Range(0.0, 360)) = 0
		_ShadowTexTransparencyCoef("Shadow Texture Transparency Coef", Range(0.0, 1.0)) = 1.0
		_ReceivedShadowsTexTransparencyCoef("Received Shadows Texture Transparency Coef", Range(0.0, 1.0)) = 1.0

		[Space(20)]

		[HDR] _ShadowColor("Shadow Color", Color) = (0.5, 0.5, 0.5, 1)
		[HDR] _ReceivedShadowsColor("Received Shadows Color", Color) = (0.5, 0.5, 0.5, 1)
		[IntRange]_ShadowNbSteps("Shadow Steps", Range(1, 16)) = 2
		_ShadowStepWidth("Shadow Step Width", Range(0, 1)) = 0.25
		_ShadowFalloff("Shadow Falloff", Range(-10, 10)) = 0

		[Space(20)]

		[HDR] _SpecularColor("Specular Color", Color) = (1,1,1,1)
		[IntRange]_SpecularNbSteps("Specular Steps", Range(1, 16)) = 2
		_SpecularStepWidth("Specular Step Width", Range(0, 1)) = 0.25
		_SpecularSize("Specular Size", float) = 0.1
		_SpecularFalloff("Specular Falloff", Range(0, 2)) = 1

		[Space(20)]

		[HDR] _RimColor("Rim Color", Color) = (1,1,1,1)
		[IntRange]_RimNbSteps("Rim Steps", Range(1, 16)) = 2
		_RimStepWidth("Rim Step Width", Range(0, 1)) = 0.25
		_RimAmount("Rim Amount", float) = 0.716
		_RimThreshold("Rim Threshold", Range(0, 1)) = 0.1


		[Space(20)]

		[HDR] _FresnelColor("Fresnel Color", Color) = (1,1,1,1)
		_FresnelPower("Fresnel Power", Range(0, 10)) = 1
		_FresnelAmount("Fresnel Amount", Range(0, 1)) = 1







		[Space(20)]
		[Header(Dithering Parameters)]
		[Space(20)]

		[NoScaleOffset] _DitherPattern("Dithering Pattern", 2D) = "white" {}
		_MinDistanceMesh("Mesh Minimum Fade Distance", Float) = 0
		_MaxDistanceMesh("Mesh Maximum Fade Distance", Float) = 1
		_MinDistanceOutline("Outline Minimum Fade Distance", Float) = 0
		_MaxDistanceOutline("Outline Maximum Fade Distance", Float) = 1











		[Space(20)]
		[Header(Halftone Parameters)]
		[Space(20)]

		[NoScaleOffset] _HalftonePattern("Halftone Pattern", 2D) = "white" {}
		[Toggle] _UseHalftone("Use Halftone", float) = 0
		[Toggle] _ScreenSpaceHalftone("Screen Space Halftone", float) = 1
		_HalftoneTexSize("Halftone Texture Size", float) = .2
		_HalftoneTexRotation("Halftone Texture Rotation", Range(0.0, 360)) = 0

		_RemapInputMin("Remap input min value", Range(0, 1)) = 0
		_RemapInputMax("Remap input max value", Range(0, 1)) = 1
		_RemapOutputMin("Remap output min value", Range(0, 1)) = 0
		_RemapOutputMax("Remap output max value", Range(0, 1)) = 1














		[Space(20)]
		[Header(First Outline Parameters)]
		[Space(20)]

		_StencilID("Stencil ID", Int) = 0	//Pour que l'outline se dessine sur les autres objets

		//Off : Affiche les deux côtés
		//Front : Affiche les faces internes
		//Back : Affiche les faces externes
		//Pour l'outline, ne changer le cull mode que si le meshCullMode est à 0 ou 1 (et affich donc les faces internes)
		[Enum(UnityEngine.Rendering.CullMode)] _OutlineCullMode("Outline Cull Mode", float) = 2

		[Toggle] _UseOutline("Use Outline", float) = 0
		[Toggle] _OutlineOnly("Outline Only", float) = 0
		[Toggle] _ColorOnly("Color Only", float) = 0
		[Toggle] _ConstantOutlineSize("Constant Outline Size", float) = 0
		[Toggle] _UseAnimation("Use Animation", float) = 0


		[Space(20)]


		[Toggle] _UseLightOnOutline("Use Light On Outline", float) = 0
		[Toggle] _LightingAffectsLightOutline("Lighting Affects Light Outline", float) = 0
		[Toggle] _GradientAffectsLighting("Gradient Affects Lighting", float) = 0
		[Toggle] _VerticalGradient("Vertical Gradient", float) = 1
		[Toggle] _InvertGradient("Invert Gradient", float) = 0


		_PivotOutlineGradient("Pivot Outline Gradient", float) = 0.5	//Permet de situer manuellement la frontière entre les 2 couleurs
		_StartOutlineGradientSmooth("Start Outline Gradient Smooth", Range(0, 1)) = 0
		_EndOutlineGradientSmooth("End Outline Gradient Smooth", Range(0, 1)) = 1
		_OutlineLightSmooth("Outline Light Smooth", Range(0, 1)) = .2


		[HDR] _OutlineFirstColor("Outline First Color", Color) = (1, 1, 1, 1)
		[HDR] _OutlineLastColor("Outline Last Color", Color) = (0, 0, 0, 1)
		[HDR] _LightOutlineColor("Light Outline Color", Color) = (1, 1, 1, 1)

		[Space(20)]

		_OutlineExtrusion("Outline Extrusion", float) = 0.003
		_OutlineDotScale("Outline Dot Scale", float) = 0.25
		_OutlineDotDistance("Outline Dot Distance", Range(-1, 1)) = 0
		_OutlineSpeed("Outline Dot Speed", float) = 300.0

		_SourcePos("Source Position", vector) = (0, 0, 0, 0)










		[Space(20)]
		[Header(Second Outline Parameters)]
		[Space(20)]

		[Toggle] _UseOutline2("Use Outline", float) = 0
		[Toggle] _ColorOnly2("Color Only", float) = 0
		[Toggle] _ConstantOutlineSize2("Constant Outline Size", float) = 0
		[Toggle] _UseAnimation2("Use Animation", float) = 0


		[Space(20)]


		[Toggle] _UseLightOnOutline2("Use Light On Outline", float) = 0
		[Toggle] _LightingAffectsLightOutline2("Lighting Affects Light Outline", float) = 0
		[Toggle] _GradientAffectsLighting2("Gradient Affects Lighting", float) = 0
		[Toggle] _VerticalGradient2("Vertical Gradient", float) = 1
		[Toggle] _InvertGradient2("Invert Gradient", float) = 0


		_PivotOutlineGradient2("Pivot Outline Gradient", float) = 0.5	//Permet de situer manuellement la frontière entre les 2 couleurs
		_StartOutlineGradientSmooth2("Start Outline Gradient Smooth", Range(0, 1)) = 0
		_EndOutlineGradientSmooth2("End Outline Gradient Smooth", Range(0, 1)) = 1
		_OutlineLightSmooth2("Outline Light Smooth", Range(0, 1)) = .2


		[HDR] _OutlineFirstColor2("Outline First Color", Color) = (1, 1, 1, 1)
		[HDR] _OutlineLastColor2("Outline Last Color", Color) = (0, 0, 0, 1)
		[HDR] _LightOutlineColor2("Light Outline Color", Color) = (1, 1, 1, 1)

		[Space(20)]

		_OutlineExtrusion2("Outline Extrusion", float) = 0.003



	}
	SubShader
	{

		//Lighting & Shadow Receiver Pass
		Pass
		{
			Cull [_MeshCullMode]
			Stencil
			{
				Ref [_StencilID]	//Pour que l'outline se dessine sur les autres objets
				Comp always
				Pass replace
			}

			// Setup our pass to use Forward rendering, and only receive
			// data on the main directional light and ambient light.
			Tags
			{
				"LightMode" = "ForwardBase" 
				"Queue" = "AlphaTest"
			}

			//Transparence
			Blend SrcAlpha OneMinusSrcAlpha


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// Compile multiple versions of this shader depending on lighting settings.
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			// Files below include macros and functions to assist
			// with lighting and shadows.
			#include "Lighting.cginc"
			#include "AutoLight.cginc"


			float4 _MainTex_ST;
			float4 _CutoutMap_ST;

			sampler2D _MainTex;
			sampler2D _OcclusionMap;
			sampler2D _NormalMap;
			sampler2D _MetallicMap;
			sampler2D _GlossMap;
			sampler2D _EmissionMap;
			sampler2D _CutoutMap;
			samplerCUBE _Cubemap;


			float _UseAmbientTint;
			float _UseAmbientSkybox; 
			float _UseSkyboxRelfection;
			float _UseEnvironmentalRelfection;
			float _NormalAffectsReflection;
			float _ReflectionAffectsShadow;
			float _Alpha;
			float _SkyboxAmbientIntensity;
			float _ReflectionIntensity;

			fixed4 _MainTexColor;
			fixed4 _LitSideColor;
			fixed4 _AmbientColor;
			half3 _Emission;
			float _Cutoff;
			float _OcclusionStrength;
			float _NormalStrength;
			float _MetallicMapStrength;
			float _GlossMapStrength;

			float _TextureEmissionIntensity;
			float _ShadowEmissionIntensity;


			sampler2D _ShadowTex;

			float _ShadowTexSize;
			float _ShadowTexRotation;
			float _ShadowTexTransparencyCoef;
			float _ReceivedShadowsTexTransparencyCoef;

			float _UseShadow;
			float _UseShadowTex;

			float _SeparateNdotlFromReceivedShadows;
			float _UseShadowTexForReceivedShadows;


			float _UseSpecular;
			float _UseRimLighting;
			float _UseFresnel;
			float _HardFresnel;

			float _DrawShadowAsSolidColor;
			float _DrawReceivedShadowsAsSolidColor;
			float _LightingAffectsShadow;
			float _LightingAffectsSpecular;
			float _LightingAffectsRim;
			float _TextureAffectsSpecular;
			float _TextureAffectsRim;
			float _RimReceivesShadows;
			float _TextureAffectsFresnel;


			float4 _ShadowColor;
			float4 _ReceivedShadowsColor;
			float _ShadowStepWidth;
			float _ShadowNbSteps;
			float _ShadowFalloff;


			fixed4 _SpecularColor;
			float _SpecularNbSteps;
			float _SpecularStepWidth;
			float _SpecularSize;
			float _SpecularFalloff;


			float4 _RimColor;
			float _RimNbSteps;
			float _RimStepWidth;
			float _RimAmount;
			float _RimThreshold;


			float4 _FresnelColor;
			float _FresnelPower;
			float _FresnelAmount;


			//The dithering pattern
			float _OutlineOnly;
			sampler2D _DitherPattern;
			float4 _DitherPattern_TexelSize;

			//remapping of distance
			float _MinDistanceMesh;
			float _MaxDistanceMesh;


			//Halftone

			//shading properties
			sampler2D _HalftonePattern;
			float4 _HalftonePattern_ST;
			float _HalftoneTexSize;
			float _HalftoneTexRotation;

			///remapping values
			float _UseHalftone;
			float _ScreenSpaceHalftone;
			float _RemapInputMin;
			float _RemapInputMax;
			float _RemapOutputMin;
			float _RemapOutputMax;






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
				screenUV *= (1 / UVscaleFactor);
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







			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 worldNormal : NORMAL;
				float2 uv : TEXCOORD0;
				float3 viewDir : TEXCOORD1;
				float4 screenPos : TEXCOORD2;
				// Macro found in Autolight.cginc. Declares a vector4
				// into the TEXCOORD3 semantic with varying precision 
				// depending on platform target.
				SHADOW_COORDS(3)

				// these three vectors will hold a 3x3 rotation matrix
				// that transforms from tangent to world space
				half3 tspace0 : TEXCOORD4; // tangent.x, bitangent.x, normal.x
				half3 tspace1 : TEXCOORD5; // tangent.y, bitangent.y, normal.y
				half3 tspace2 : TEXCOORD6; // tangent.z, bitangent.z, normal.z

				half3 worldRefl : TEXCOORD7;	//Pour les rélfections
				half2 cutoffUV : TEXCOORD8;	
				fixed4 skyAmbient : COLOR0;	//Pour l'ambient de la skybox
			};

			v2f vert(appdata v)
			{
				v2f o;

				/////////////////////// V2F INIT /////////////////////////////////////////

				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.cutoffUV = TRANSFORM_TEX(v.uv, _CutoutMap);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				o.screenPos = ComputeScreenPos(o.pos);

				// Defined in Autolight.cginc. Assigns the above shadow coordinate
				// by transforming the vertex from world space to shadow-map space.
				TRANSFER_SHADOW(o)

				///////////////////////// NORMAL MAP /////////////////////////////////////////


				half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
				// compute bitangent from cross product of normal and tangent
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 wBitangent = cross(o.worldNormal, wTangent) * tangentSign;
				// output the tangent space matrix
				o.tspace0 = half3(wTangent.x, wBitangent.x, o.worldNormal.x);
				o.tspace1 = half3(wTangent.y, wBitangent.y, o.worldNormal.y);
				o.tspace2 = half3(wTangent.z, wBitangent.z, o.worldNormal.z);


				///////////////////////// REFLECTION /////////////////////////////////////////


				// world space reflection vector
				o.worldRefl = reflect(-o.viewDir, o.worldNormal);


				///////////////////////// SKYBOX AMBIENT /////////////////////////////////////////

				o.skyAmbient.rgb = ShadeSH9(half4(o.worldNormal, 1));


				return o;
			}






			float4 frag(v2f i) : SV_Target
			{

				float4 white = float4(1, 1, 1, 1);
				float4 black = float4(0, 0, 0, 0);

				float3 viewDir = normalize(i.viewDir);

				// Samples the shadow map, returning a value in the 0...1 range,
				// where 0 is in the shadow, and 1 is not.
				float shadowAtten = SHADOW_ATTENUATION(i);

				///////////////////////// NORMAL MAP ///////////////////////////////////////

				// sample the normal map, and decode from the Unity encoding
				half3 tnormal = UnpackNormal(tex2D(_NormalMap, i.uv));
				tnormal.xy *= _NormalStrength;
				tnormal = normalize(tnormal);
				// transform normal from tangent to world space
				half3 normal;
				normal.x = dot(i.tspace0, tnormal);
				normal.y = dot(i.tspace1, tnormal);
				normal.z = dot(i.tspace2, tnormal);


				//On combine la normal map avec la réflexion de l'environnement et de la skybox
				i.worldRefl = lerp(i.worldRefl, reflect(-i.viewDir, normal), _NormalAffectsReflection);



				///////////////////////////// LIGHT CALCULATION ///////////////////////////////


				// Lighting below is calculated using Blinn-Phong,
				// with values thresholded to create the "toon" look.
				// https://en.wikipedia.org/wiki/Blinn-Phong_shading_model


				// Calculate illumination from directional light.
				// _WorldSpaceLightPos0 is a vector pointing the OPPOSITE
				// direction of the main directional light.
				float NdotL = dot(_WorldSpaceLightPos0, normal);

				//stretch values so each whole value is one step
				NdotL = NdotL / _ShadowStepWidth;

				//Pour permettre de décaler la limite entre ombres et lumière
				NdotL += _ShadowFalloff;

				//make steps harder
				float lightIntensity = floor(NdotL);

				// calculate smoothing in first pixels of the steps and add smoothing to step, raising it by one step
				// (that's fine because we used floor previously and we want everything to be the value above the floor value, 
				// for example 0 to 1 should be 1, 1 to 2 should be 2 etc...)
				float change = fwidth(NdotL);
				float smoothing = smoothstep(0, change, frac(NdotL));
				lightIntensity = lightIntensity + smoothing;

				// bring the light intensity back into a range where we can use it for color
				// and clamp it so it doesn't do weird stuff below 0 / above one
				lightIntensity = lightIntensity / _ShadowNbSteps;
				lightIntensity = saturate(lightIntensity);








				///////////////////////////// HALFTONE ///////////////////////////////

				//Pour le halftone, on recalcule la lumière et on la multiplie par la lightIntensity qu'on avait déjà.
				//Ca ne donne pas exactement le résultat qu'on cherchait, puisque la condition suffisait à obtenir l'halftone,
				//Mais je trouve que c'est plus joli comme ça

				//Faire attention à augmenter la bias dans la Directional Light pour faire disparaître les petites ombres
				//et éviter les artéfacts quand on zoome sur les ombres

				
				//setup screenspace UVs for lighting function
				float2 scrUV = GetScreenUV(i.screenPos, _HalftoneTexSize);
				float2 worldUV = i.uv * (1 / _HalftoneTexSize);
				scrUV = TRANSFORM_TEX(rotateUV(lerp(worldUV, scrUV, _ScreenSpaceHalftone), _HalftoneTexRotation), _HalftonePattern);

				//get halftone comparison value
				float halftoneValue = tex2D(_HalftonePattern, scrUV).r;


				//how much does the normal point towards the light?
				//remap the value from -1 to 1 to between 0 and 1
				NdotL = lerp(NdotL, NdotL * 0.5 + 0.5, _UseHalftone);
				//combine shadow and light and clamp the result between 0 and 1
				float lightInt = saturate(NdotL).r;

				//make lightness binary between fully lit and fully shadow based on halftone pattern (with a bit of antialiasing between)
				halftoneValue = map(halftoneValue, _RemapInputMin, _RemapInputMax, _RemapOutputMin, _RemapOutputMax);
				float halftoneChange = fwidth(halftoneValue) * 0.5;
				lightInt = smoothstep(halftoneValue - halftoneChange, halftoneValue + halftoneChange, lightInt);
				lightIntensity = lightIntensity * lerp(1, lightInt, _UseHalftone);










				///////////////////////////// SHADOWS ///////////////////////////////


				//Vient après le calcul de l'halftone pour éviter les artefacts avec les ombres reçues


				//Ajout des ombres reçues par l'objet, adoucies pour éviter un effet dentelé
				//On a toujours des artefacts qd on zoome, mais c'est mieux que rien. On l'améliorera plus tard.

				//for directional lights, get a hard vut in the middle of the shadow attenuation
				float attenuationChange = fwidth(shadowAtten) * 0.5;
				float shadow = smoothstep(0.5 - attenuationChange, 0.5 + attenuationChange, shadowAtten);

				//Si on ne sépare pas les ombres reçues du NdotL, on ne multiplie pas l'intensité par l'ombre tt de suite
				//(on fera le calcul au moment de l'ajout de la texture)
				float lightIntensityWithoutShadows = lightIntensity;
				lightIntensity *= lerp(1, shadow, lerp(1, 0, _SeparateNdotlFromReceivedShadows));








				///////////////////////////// SPECULAR ///////////////////////////////



				//calculate how much the surface points points towards the reflection direction
				float3 reflectionDirection = reflect(_WorldSpaceLightPos0, normal);
				float towardsReflection = dot(viewDir, -reflectionDirection);

				//make specular highlight all off towards outside of model
				float specularFalloff = dot(viewDir, normal);


				specularFalloff = pow(specularFalloff, _SpecularFalloff);
				towardsReflection = towardsReflection * specularFalloff;

				towardsReflection /= _SpecularStepWidth;
				towardsReflection += _SpecularSize;


				//make specular intensity with a hard corner
				//float specularChange = fwidth(towardsReflection);
				//float specularIntensity = smoothstep(1 - _SpecularSize, 1 - _SpecularSize + specularChange, towardsReflection);

				float specularIntensity = floor(towardsReflection);
				specularIntensity /= _SpecularNbSteps;
				specularIntensity = saturate(specularIntensity);

				//factor inshadows
				specularIntensity *= lerp(1, shadow, _UseShadow) * _SpecularColor.a;





				///////////////////////////// RIM ///////////////////////////////



				// Calculate rim lighting.
				float rimDot = 1 - dot(viewDir, normal);
				rimDot /= _RimStepWidth;
				rimDot += _RimAmount;

				// We only want rim to appear on the lit side of the surface,
				// so multiply it by NdotL, raised to a power to smoothly blend it.
				float rimIntensity = floor(rimDot * NdotL * _RimThreshold);

				// bring the light intensity back into a range where we can use it for color
				// and clamp it so it doesn't do weird stuff below 0 / above one
				rimIntensity /= _RimNbSteps;
				rimIntensity = saturate(rimIntensity);
				rimIntensity *= lerp(1, lerp(1, shadow, _RimReceivesShadows), _UseShadow);

				//Pour s'assurer que la bordure reste nette
				//rimIntensity = smoothstep(1 - _RimAmount, 1 - _RimAmount, rimIntensity) * _RimColor.a;






				///////////////////////////// FRESNEL ///////////////////////////////

				//Pas besoin de calculer la direction de la lumière puisqu'on l'a déjà dans rimDot.
				//On regarde seulement si on veut un fresnel doux ou dur, puis on l'ajoute à la couleur dans la dernière section
				float fresnelDot = 1 - dot(viewDir, normal);
				float fresnel = pow(fresnelDot, _FresnelPower);
				fresnel = lerp(fresnel, smoothstep(1 - _FresnelAmount, 1 - _FresnelAmount, fresnel), _HardFresnel);






				///////////////////////////// DITHERING ///////////////////////////////



				//value from the dither pattern
				float2 screenPos = i.screenPos.xy / i.screenPos.w;
				float2 ditherCoordinate = screenPos * _ScreenParams.xy * _DitherPattern_TexelSize.xy;
				float ditherValue = tex2D(_DitherPattern, ditherCoordinate).r;

				//get relative distance from the camera
				float relDistance = i.screenPos.w;
				relDistance = relDistance - _MinDistanceMesh;
				relDistance = relDistance / (_MaxDistanceMesh - _MinDistanceMesh);
				//discard pixels accordingly
				clip(relDistance - ditherValue);







				///////////////////////////// REFLEXION ///////////////////////////////



				// sample the default reflection cubemap, using the reflection vector
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, i.worldRefl);
				// decode cubemap data into actual color
				half3 skyColor = lerp(white, DecodeHDR(skyData, unity_SpecCube0_HDR), _UseSkyboxRelfection);

				// sample the environmental cubemap
				half4 envData = texCUBE(_Cubemap, i.worldRefl);
				// decode cubemap data into actual color
				half3 envColor = lerp(white, DecodeHDR(envData, unity_SpecCube0_HDR), _UseEnvironmentalRelfection);

				float4 reflections = float4(skyColor * envColor, 1);






				///////////////////////////// COLORS ///////////////////////////////




				//calculate final color
				float4 color;
				float4 inverseColor;
				float4 ndotlShadowTex;
				float4 receivedShadowTex;

				float cutout = tex2D(_CutoutMap, i.cutoffUV).a;
				float4 occlusion = lerp(white, tex2D(_OcclusionMap, i.uv), _OcclusionStrength);
				half3 emission = tex2D(_EmissionMap, i.uv) * _Emission;
				half metallic = tex2D(_MetallicMap, i.uv).r;
				half gloss = lerp(white, tex2D(_GlossMap, i.uv).r, _GlossMapStrength);
				float4 tex = tex2D(_MainTex, i.uv) * _MainTexColor * _TextureEmissionIntensity * occlusion;








				//La position en screen space pour la texture de l'ombre
				float2 screenUV = GetScreenUV(i.screenPos, _ShadowTexSize);
				screenUV = rotateUV(screenUV, _ShadowTexRotation);
				ndotlShadowTex = tex2D(_ShadowTex, screenUV) * _ShadowEmissionIntensity;
				receivedShadowTex = ndotlShadowTex;




				//La couleur de l'ombre séparée entre NdotL et ombres reçues par l'objet
				float4 shouldLightingAffectShadows = lerp(white, _LightColor0, _LightingAffectsShadow);
				float inverselightIntensity = 1 - lightIntensity;

				//Ajout de la texture pour l'ombre calculée avec NdotL
				ndotlShadowTex = ndotlShadowTex * _UseShadowTex * (inverselightIntensity) + (inverselightIntensity) * (1 - _UseShadowTex);
				ndotlShadowTex = lerp((inverselightIntensity), ndotlShadowTex, _ShadowTexTransparencyCoef);
				ndotlShadowTex = ndotlShadowTex * shouldLightingAffectShadows * _ShadowColor;


				//On recalcule l'intensité de la lumière pour les ombres reçues par l'objet
				lightIntensity = lerp(lightIntensity, lightIntensityWithoutShadows - lightIntensityWithoutShadows * shadow, _SeparateNdotlFromReceivedShadows);
				float receivedShadowLightIntensity = lightIntensity;

				//Ajout de la texture pour l'ombre reçue par l'objet
				float4 receivedShadowColorToUse = lerp(_ShadowColor, _ReceivedShadowsColor, _SeparateNdotlFromReceivedShadows);

				receivedShadowTex = receivedShadowTex * _UseShadowTexForReceivedShadows * (lightIntensity) + (lightIntensity) * (1 - _UseShadowTexForReceivedShadows);
				receivedShadowTex = lerp((lightIntensity), receivedShadowTex, _ReceivedShadowsTexTransparencyCoef);
				receivedShadowTex = receivedShadowTex * shouldLightingAffectShadows * receivedShadowColorToUse;




				//On remet ensuite la lightIntensity à la normale pour le reste des calculs
				lightIntensity = lightIntensityWithoutShadows * shadow;
				lightIntensity = lerp(1, lightIntensity, _UseShadow);




				

				//Pour color et inverseColor, on fait un lerp entre la surface éclairée et celle dans l'ombre pour appliquer
				//la texture de l'objet ou de l'ombre en fonction du résultat.
				//Chacune des deux couleurs affiche donc la mainTex mais avec des ombres différentes.
				//On ne fait ensuite qu'échanger les deux textures si on veut des couleurs solides ou pas.
				ndotlShadowTex *= lerp(tex, 1, _DrawShadowAsSolidColor);
				receivedShadowTex *= lerp(tex, 1, _DrawReceivedShadowsAsSolidColor);
				ndotlShadowTex += lerp(0, receivedShadowTex, _SeparateNdotlFromReceivedShadows);





				//On ajoute la réflexion ici si elle doit affecter l'ombre
				float4 reversedReflections = reflections;
				reflections = reflections * metallic;
				reversedReflections = lerp(reversedReflections, white, _MetallicMapStrength);


				//Calcul des côtés sombre et éclairé

				float4 lightenSide = _LitSideColor * tex * _LightColor0;
				float4 reversedLightenSide = lightenSide * (1 - metallic);
				lightenSide *= lerp(metallic, reflections, _ReflectionIntensity);
				reversedLightenSide *= lerp(white, reversedReflections, _ReflectionIntensity);
				lightenSide += reversedLightenSide;

				float4 shadowSide = ndotlShadowTex; 
				float4 reversedShadowSide = shadowSide * (1 - metallic);
				shadowSide *= lerp(metallic, reflections, _ReflectionIntensity * _ReflectionAffectsShadow);
				reversedShadowSide *= lerp(white, reversedReflections, _ReflectionIntensity * _ReflectionAffectsShadow);
				shadowSide += reversedShadowSide;


				color = lerp(shadowSide, lightenSide, lightIntensity);






				//Ajout de la specular et de la rim

				float4 reflOnSpecAndRim = reflections + white * (1 - metallic) * reversedReflections;

				float4 shouldLightingAffectSpecular = lerp(white, _LightColor0, _LightingAffectsSpecular) *
					lerp(white, tex, _TextureAffectsSpecular) *
					lerp(white, reflOnSpecAndRim, _ReflectionIntensity) *
					_SpecularColor;

				float4 shouldLightingAffectRim = lerp(white, _LightColor0, _LightingAffectsRim) *
					lerp(white, tex, _TextureAffectsRim) *
					lerp(white, reflOnSpecAndRim, _ReflectionIntensity) *
					//smoothstep(float4(1,0,0,1), float4(0, 0, 1, 1), floor(NdotL * .22)) *	//Pour l'effet vaporwave sur la rim
					_RimColor;


				color.rgb = lerp(color.rgb, shouldLightingAffectSpecular, saturate(specularIntensity) * gloss * _UseSpecular);
				color.rgb = lerp(color.rgb, shouldLightingAffectRim, saturate(rimIntensity) * gloss * _UseRimLighting);








				//Ajout du fresnel
				color.rgb += lerp(black, fresnel * _FresnelColor, _UseFresnel) * lerp(white, tex, _TextureAffectsFresnel);

				//Emission globale
				color.rgb += emission;







				//Ambient
				//_AmbientColor.a permet de réduire la force de la couleur indépendamment de l'émission
				float3 ambientSkybox = i.skyAmbient * _UseAmbientSkybox * _SkyboxAmbientIntensity;
				float3 ambientTint = _AmbientColor.rgb * _AmbientColor.a * _UseAmbientTint;
				_AmbientColor.rgb = ambientTint + ambientSkybox;

				color.rgb += _AmbientColor;







				//Cutout & Alpha

				color.a = step(_Cutoff * (1 - _OutlineOnly), cutout);
				//clip(cutout - _Cutoff);
				color.a *= _Alpha;

				return color;
			}


			ENDCG
		}


		//Additional Lights
		

		//First Outline pass
		Pass
		{

			Cull[_OutlineCullMode]
			ZWrite Off
			ZTest On

			Stencil
			{
			// Won't draw where it sees ref value ID
			Ref[_StencilID]
			Comp notequal
			Pass replace
		}

			//Transparence
			Blend SrcAlpha OneMinusSrcAlpha


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			#include "AutoLight.cginc"


			//The dithering pattern
			sampler2D _DitherPattern;
			float4 _DitherPattern_TexelSize;

			//remapping of distance
			float _MinDistanceOutline;
			float _MaxDistanceOutline;




			// Properties

			sampler2D _MainTex;
			float _Alpha;


			float _UseOutline;
			float _ColorOnly;
			float _UseLightOnOutline;
			float _LightingAffectsLightOutline;
			float _GradientAffectsLighting;

			float _UseAnimation;
			float _ConstantOutlineSize;
			float _VerticalGradient;
			float _InvertGradient;
			float _UseSmoothOutlineGradient;

			uniform float4 _OutlineFirstColor;
			uniform float4 _OutlineLastColor;
			uniform float4 _LightOutlineColor;
			uniform float _PivotOutlineGradient;
			uniform float _StartOutlineGradientSmooth;
			uniform float _EndOutlineGradientSmooth;
			uniform float _OutlineLightSmooth;

			uniform float _OutlineExtrusion;
			float  _OutlineDotScale;
			float  _OutlineDotDistance;
			float  _OutlineSpeed;
			float4 _SourcePos;







			float2 GetScreenUV(float4 clipPos)
			{
				float2 screenUV = clipPos.xy / clipPos.w;
				float aspect = _ScreenParams.x / _ScreenParams.y;
				screenUV.x = screenUV.x * aspect;

				return screenUV;
			}

			float Remap(float from, float fromMin, float fromMax, float toMin, float toMax)
			{
				float fromAbs = from - fromMin;
				float fromMaxAbs = fromMax - fromMin;

				float normal = fromAbs / fromMaxAbs;

				float toMaxAbs = toMax - toMin;
				float toAbs = toMaxAbs * normal;

				float to = toAbs + toMin;

				return to;
			}







			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texCoord : TEXCOORD0;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 screenCoord : TEXCOORD0;
				float4 texCoord : TEXCOORD1;
				float4 gradientCoord : TEXCOORD2;
				float3 normal : NORMAL;

			};

			vertexOutput vert(vertexInput i)
			{
				vertexOutput o;

				float4 newPos = i.vertex;
				float4 screenCoord = ComputeScreenPos(UnityObjectToClipPos(newPos));


				// normal extrusion technique
				float3 normal = normalize(i.normal);
				newPos += float4(normal, 0.0) * _OutlineExtrusion * lerp(1, screenCoord.w, _ConstantOutlineSize);



				// convert to world space for the animation
				o.pos = UnityObjectToClipPos(newPos);


				//infos pour le dégradé de couleur
				o.texCoord = i.texCoord;
				o.gradientCoord = i.vertex;


				// get screen coordinates (pour le dithering)
				screenCoord = ComputeScreenPos(o.pos);
				o.screenCoord = screenCoord;


				//normal pour le calcul de la lumière
				o.normal = UnityObjectToWorldNormal(i.normal);

				return o;
			}

			float4 frag(vertexOutput i) : COLOR
			{
				float4 black = float4(0,0,0,0);
				float4 white = float4(1,1,1,1);


				/////////////////////////// ANIMATION //////////////////////////

				//INFO : Multiplier i.pos.xy par lui-même crée plusieurs ondes les unes sur les autres


				// dotted line with animation;
				float2 pos = i.pos.xy/* * i.pos.xy *//*+ _Time * _OutlineSpeed*/;
				float skip = sin(_OutlineDotScale * distance(_SourcePos.xy, pos) + _Time * _OutlineSpeed) + _OutlineDotDistance;
				clip(skip * _UseAnimation); // stops rendering a pixel if 'skip' is negative



				/////////////////////////// DITHERING //////////////////////////




				//value from the dither pattern
				float2 screenPos = i.screenCoord.xy / i.screenCoord.w;
				float2 ditherCoordinate = screenPos * _ScreenParams.xy * _DitherPattern_TexelSize.xy;
				float ditherValue = tex2D(_DitherPattern, ditherCoordinate).r;

				//get relative distance from the camera
				float relDistance = i.screenCoord.w;
				relDistance = relDistance - _MinDistanceOutline;
				relDistance = relDistance / (_MaxDistanceOutline - _MinDistanceOutline);


				//discard pixels accordingly
				clip(relDistance - ditherValue);






				/////////////////////////// LIGHTING //////////////////////////


				//stretch values so each whole value is one step
				float NdotL = dot(_WorldSpaceLightPos0, i.normal);
				NdotL = smoothstep(0, _OutlineLightSmooth, NdotL);

				float4 mainLight = float4(NdotL.xxx, 1) * _LightOutlineColor;
				mainLight = lerp(mainLight, mainLight * _LightColor0, _LightingAffectsLightOutline);

				//A FAIRE : Ajouter les autres sources de lumière



				/////////////////////////// COLORS //////////////////////////


				//On récupère la position des vertex pour faire un lerp en fonction de la taille, position et rotation de l'objet
				//On choisit ensuite si on veut un dégradé vertical ou horizontal

				float xOrY = lerp(i.gradientCoord.x, i.gradientCoord.y, _VerticalGradient) * lerp(1, -1, _InvertGradient);

				//Permet de décaler la frontière entre les deux couleurs
				xOrY += _PivotOutlineGradient;

				//Permet le dégradé en lui-même. Resserrer les 2 valeurs rend la frontière plus nette
				float t = smoothstep(_StartOutlineGradientSmooth, _EndOutlineGradientSmooth, xOrY);




				//On ajoute toutes les couleurs ensemble
				//On utilise un saturate pour la couleur du lerp car on y ajoute les halos de lumière
				//et on ne veut pas que les couleurs dépassent les deux valeurs du dégradé

				fixed4 gradientColor = lerp(_OutlineLastColor, _OutlineFirstColor, t);

				fixed4 endGradientColor = saturate(lerp(
					gradientColor,

					lerp(lerp(
						gradientColor, mainLight, NdotL),
						gradientColor + mainLight,
						_GradientAffectsLighting),

					_UseLightOnOutline));

				fixed4 color = lerp(float4(0, 0, 0, 0),
					lerp(tex2Dlod(_MainTex, float4(i.texCoord.xy, 0, 0)), float4(1, 1, 1, 1), _ColorOnly) *
					endGradientColor,
					_UseOutline);


				return color * _Alpha;
			}

			ENDCG
		}

		//Second Outline pass
		Pass
		{

			Cull[_OutlineCullMode]
			ZWrite Off
			ZTest On

			Stencil
			{
			// Won't draw where it sees ref value ID
			Ref[_StencilID]
			Comp notequal
			Pass replace
		}

			//Transparence
			Blend SrcAlpha OneMinusSrcAlpha


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			#include "AutoLight.cginc"


			//The dithering pattern
			sampler2D _DitherPattern;
			float4 _DitherPattern_TexelSize;

			//remapping of distance
			float _MinDistanceOutline;
			float _MaxDistanceOutline;




			// Properties

			sampler2D _MainTex;
			float _Alpha;


			float _UseOutline2;
			float _ColorOnly2;
			float _UseLightOnOutline2;
			float _LightingAffectsLightOutline2;
			float _GradientAffectsLighting2;

			float _UseAnimation2;
			float _ConstantOutlineSize2;
			float _VerticalGradient2;
			float _InvertGradient2;
			float _UseSmoothOutlineGradient2;

			uniform float4 _OutlineFirstColor2;
			uniform float4 _OutlineLastColor2;
			uniform float4 _LightOutlineColor2;
			uniform float _PivotOutlineGradient2;
			uniform float _StartOutlineGradientSmooth2;
			uniform float _EndOutlineGradientSmooth2;
			uniform float _OutlineLightSmooth2;

			uniform float _OutlineExtrusion2;
			float  _OutlineDotScale;
			float  _OutlineDotDistance;
			float  _OutlineSpeed;
			float4 _SourcePos;







			float2 GetScreenUV(float4 clipPos)
			{
				float2 screenUV = clipPos.xy / clipPos.w;
				float aspect = _ScreenParams.x / _ScreenParams.y;
				screenUV.x = screenUV.x * aspect;

				return screenUV;
			}

			float Remap(float from, float fromMin, float fromMax, float toMin, float toMax)
			{
				float fromAbs = from - fromMin;
				float fromMaxAbs = fromMax - fromMin;

				float normal = fromAbs / fromMaxAbs;

				float toMaxAbs = toMax - toMin;
				float toAbs = toMaxAbs * normal;

				float to = toAbs + toMin;

				return to;
			}







			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texCoord : TEXCOORD0;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 screenCoord : TEXCOORD0;
				float4 texCoord : TEXCOORD1;
				float4 gradientCoord : TEXCOORD2;
				float3 normal : NORMAL;

			};

			vertexOutput vert(vertexInput i)
			{
				vertexOutput o;

				float4 newPos = i.vertex;
				float4 screenCoord = ComputeScreenPos(UnityObjectToClipPos(newPos));


				// normal extrusion technique
				float3 normal = normalize(i.normal);
				newPos += float4(normal, 0.0) * _OutlineExtrusion2 * lerp(1, screenCoord.w, _ConstantOutlineSize2);



				// convert to world space for the animation
				o.pos = UnityObjectToClipPos(newPos);


				//infos pour le dégradé de couleur
				o.texCoord = i.texCoord;
				o.gradientCoord = i.vertex;


				// get screen coordinates (pour le dithering)
				screenCoord = ComputeScreenPos(o.pos);
				o.screenCoord = screenCoord;


				//normal pour le calcul de la lumière
				o.normal = UnityObjectToWorldNormal(i.normal);

				return o;
			}

			float4 frag(vertexOutput i) : COLOR
			{
				float4 black = float4(0,0,0,0);
				float4 white = float4(1,1,1,1);


				/////////////////////////// ANIMATION //////////////////////////

				//INFO : Multiplier i.pos.xy par lui-même crée plusieurs ondes les unes sur les autres


				// dotted line with animation;
				float2 pos = i.pos.xy/* * i.pos.xy *//*+ _Time * _OutlineSpeed*/;
				float skip = sin(_OutlineDotScale * distance(_SourcePos.xy, pos) + _Time * _OutlineSpeed) + _OutlineDotDistance;
				clip(skip* _UseAnimation2); // stops rendering a pixel if 'skip' is negative



				/////////////////////////// DITHERING //////////////////////////




				//value from the dither pattern
				float2 screenPos = i.screenCoord.xy / i.screenCoord.w;
				float2 ditherCoordinate = screenPos * _ScreenParams.xy * _DitherPattern_TexelSize.xy;
				float ditherValue = tex2D(_DitherPattern, ditherCoordinate).r;

				//get relative distance from the camera
				float relDistance = i.screenCoord.w;
				relDistance = relDistance - _MinDistanceOutline;
				relDistance = relDistance / (_MaxDistanceOutline - _MinDistanceOutline);


				//discard pixels accordingly
				clip(relDistance - ditherValue);






				/////////////////////////// LIGHTING //////////////////////////


				//stretch values so each whole value is one step
				float NdotL = dot(_WorldSpaceLightPos0, i.normal);
				NdotL = smoothstep(0, _OutlineLightSmooth2, NdotL);

				float4 mainLight = float4(NdotL.xxx, 1) * _LightOutlineColor2;
				mainLight = lerp(mainLight, mainLight * _LightColor0, _LightingAffectsLightOutline2);

				//A FAIRE : Ajouter les autres sources de lumière



				/////////////////////////// COLORS //////////////////////////


				//On récupère la position des vertex pour faire un lerp en fonction de la taille, position et rotation de l'objet
				//On choisit ensuite si on veut un dégradé vertical ou horizontal

				float xOrY = lerp(i.gradientCoord.x, i.gradientCoord.y, _VerticalGradient2) * lerp(1, -1, _InvertGradient2);

				//Permet de décaler la frontière entre les deux couleurs
				xOrY += _PivotOutlineGradient2;

				//Permet le dégradé en lui-même. Resserrer les 2 valeurs rend la frontière plus nette
				float t = smoothstep(_StartOutlineGradientSmooth2, _EndOutlineGradientSmooth2, xOrY);




				//On ajoute toutes les couleurs ensemble
				//On utilise un saturate pour la couleur du lerp car on y ajoute les halos de lumière
				//et on ne veut pas que les couleurs dépassent les deux valeurs du dégradé

				fixed4 gradientColor = lerp(_OutlineLastColor2, _OutlineFirstColor2, t);

				fixed4 endGradientColor = saturate(lerp(
					gradientColor,

					lerp(lerp(
						gradientColor, mainLight, NdotL),
						gradientColor + mainLight,
						_GradientAffectsLighting2),

					_UseLightOnOutline2));

				fixed4 color = lerp(float4(0, 0, 0, 0),
					lerp(tex2Dlod(_MainTex, float4(i.texCoord.xy, 0, 0)), float4(1, 1, 1, 1), _ColorOnly2) *
					endGradientColor,
					_UseOutline2);



				return color * _Alpha;
			}

			ENDCG
		}



		// Shadow Caster pass
		Pass
		{
			Tags {"LightMode" = "ShadowCaster"}

			ZWrite On 
			ZTest LEqual 
			Cull [_MeshCullMode]

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "UnityCG.cginc"



			uniform float4 _CutoutMap_ST;
			uniform sampler2D _CutoutMap;
			uniform fixed _Cutoff;
			uniform fixed _Alpha;

			fixed _CastShadows;



			struct v2f {
				V2F_SHADOW_CASTER;
				float2  uv : TEXCOORD1;
			};



			v2f vert(appdata_base v) {
				v2f o;
				TRANSFER_SHADOW_CASTER(o)
				o.uv = TRANSFORM_TEX(v.texcoord, _CutoutMap);
				return o;
			}

			float4 frag(v2f i) : COLOR {
				fixed alpha = tex2D(_CutoutMap, i.uv).a;
				// or if you want to use grayscale texture:
				// fixed alpha = tex2D(_CutoutMap, i.uv).r;
				clip(alpha - _Cutoff);
				SHADOW_CASTER_FRAGMENT(i);

#ifdef SHADOWS_DEPTH
				if (unity_LightShadowBias.z != 0.0) {
					// shadow
				}
				else {
					// camera depth
				}
#endif

			}
		ENDCG
		}

		// pull in shadow caster from VertexLit built-in shader
		//UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"

	

	}		
	//Fallback "Transparent/Cutout/VertexLit"
	//Fallback "Transparent/Cutout/Diffuse"
}