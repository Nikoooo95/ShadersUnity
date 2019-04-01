Shader "Custom/ButtonShader"
{
    Properties
    {
		//Button Texture
        _MainTex ("Main Texture", 2D) = "white" {}
		
		//Mask from Button Texture
		_MaskMainTexture ("Mask Main Texture", 2D) = "white" {}

		//Loading Mask Texture
		_LoadingMask("Loading Mask Effect", 2D) = "white" {}
		
		//Noise for the Glow effect
		_Noise("Noise Effect", 2D) = "white" {}

		//Color of the Glow effect
		_Color("Glow Color Effect", Color) = (1, 1, 1, 1)

		//Type Effect: 0 -> Loading. 1 -> Glowing
		_TypeEffect("Type of Effect", Range(0,1)) = 1.0

		//Range of the Loading Effect
		_RangeEffect("Range of the Effect", Range(0,1)) = 1.0
		
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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

			//Main Texture
            sampler2D _MainTex;

			//Mask from Button Texture
			sampler2D _MaskMainTexture;

			//Loading Mask Texture
			sampler2D _LoadingMask;

			//Noise for the Glow effect
			sampler2D _Noise;

			//Color of the Glow effect
			fixed4 _Color;
		
			half _TypeEffect;
			//Type Effect: 0 -> Loading. 1 -> Glowing

			//Range of the Loading Effect
			half _RangeEffect;

			//Return new UV position based in time
			float2 flowUV(float2 uv, float time) {
				return uv - time * 0.3;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 result = tex2D(_MainTex, i.uv);
				float2 uv = flowUV(i.uv, _Time.y);
				fixed4 mask = tex2D(_MaskMainTexture, i.uv);
				fixed4 loadingMask = tex2D(_LoadingMask, i.uv);
				fixed4 noise = tex2D(_Noise, uv);

				//First line: Glow Effect. Result = Noise Texture * Glow Color * Mask Texture + Main Texture
				//Second Line: Loading Effect: If range value is over mask red channel, makes the result as B&W.

				//Depending of Type Effect value, will apply the Glow Effect or the Loading Effet

				result.rgb = _TypeEffect * (noise.rgb * _Color * mask.rgb + result.rgb) +
					(1 - _TypeEffect) *  ((step(loadingMask.r, _RangeEffect) * Luminance(result.rgb) * 0.5) + ((1 - step(loadingMask.r, _RangeEffect))* result.rgb));
				
                return result;
            }
            ENDCG
        }
    }
}
