Shader "Custom/ButtonLoadingShader"
{
	Properties
	{
		//Button Texture
		_MainTex("Main Texture", 2D) = "white" {}

		//Radial Mask Texture
		_MaskTex("Radial Mask Texture", 2D) = "white" {}

		//Range of the Radial Effect
		_RangeEffect("Range Effect", Range(0,1)) = 1.0
	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;
					return o;
				}

				//Main Texture
				sampler2D _MainTex;

				//Radial Mask Texture
				sampler2D _MaskTex;

				//Range of the Radial Effect
				half _RangeEffect;

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 result = tex2D(_MainTex, i.uv);
					fixed4 mask = tex2D(_MaskTex, i.uv);

					//If range value is over mask red channel, makes the result as B&W
					
					result.rgb = step(mask.r, _RangeEffect) * Luminance(result.rgb) * 0.8 + (1- step(mask.r, _RangeEffect)) * result.rgb ;
					

					return result;
				}

			ENDCG
			}
		}
}
