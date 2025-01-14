﻿Shader "Custom/KnightShader"
{
    Properties
    {
		
		//Main Texture
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

		//Color for the texture
		_Color("Color", Color) = (1,1,1,1)

		//Smoothness of the material
        _Glossiness ("Smoothness", Range(0,1)) = 0.5

		//Metallic of the material
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard addshadow

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

		//Main Texture
        sampler2D _MainTex;

		//UV
        struct Input
        {
            float2 uv_MainTex;
        };

		//Color for the texture
		fixed4 _Color;

		//Smoothness of the material
        half _Glossiness;

		//Metallic of the material
        half _Metallic;
        

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 tex = tex2D (_MainTex, IN.uv_MainTex);

			//Albedo = Mask * Color + Original Albedo * (1 - Mask)
			o.Albedo = tex.a * _Color + tex.rgb * (1.0 - tex.a);

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
