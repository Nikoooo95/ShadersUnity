Shader "Custom/ButtonGlowShader"
{
    Properties
    {
		//Button Texture
        _MainTex ("Main Texture", 2D) = "white" {}

		//Mask from Button Texture
		_MaskTex ("Mask Texture", 2D) = "white" {}

		//Noise for the Glow effect
		_Noise ("Noise Texture", 2D) = "white" {}

		//Color of the Glow effect
		_Color("Glow Color", Color) = (1,1,1,1)
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

			//Button Texture
            sampler2D _MainTex;

			//Mask from Button Texture
			sampler2D _MaskTex;

			//Noise for the Glow effect
			sampler2D _Noise;

			//Color of the Glow effect
			fixed4 _Color;
			
			//Return new UV position based in time
			float2 flowUV(float2 uv, float time) {
				
				return uv - time * 0.3;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 result = tex2D(_MainTex, i.uv);
				float2 uv = flowUV(i.uv, _Time.y);
				fixed4 mask = tex2D(_MaskTex, i.uv);
				fixed4 noise = tex2D(_Noise, uv);

				//Result = Noise Texture * Glow Color * Mask Texture + Main Texture
				result.rgb = noise.rgb * _Color * mask.rgb + result.rgb;

                return result;
            }


            ENDCG
        }
    }
}
