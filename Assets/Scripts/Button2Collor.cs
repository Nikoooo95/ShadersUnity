using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Button2Collor : MonoBehaviour
{

    
    /// <summary>
    /// False: Not on Loading Mode
    /// True: On Loading Mode
    /// </summary>
    bool loading = false;

    /// <summary>
    /// False: Is Linear Loading Effect. 
    /// True: Is Radial Loading Effect.
    /// </summary>
    bool isRadial = false;

    /// <summary>
    /// Texture for a Linear Loading Effect
    /// </summary>
    [SerializeField]
    private Texture2D linearEffect = null;

    /// <summary>
    /// Texture for a Radial Loading Effect
    /// </summary>
    [SerializeField]
    private Texture2D radialEffect = null;

    /// <summary>
    /// Makes the Glow Material as default
    /// </summary>
    public void Awake()
    {
        GetComponent<Image>().material.SetFloat("_TypeEffect", 1);
    }

    /// <summary>
    /// Sets a different loading Effect on the texture of the material.
    /// </summary>
    public void ChangeEffect()
    {
        if (!isRadial)
            GetComponent<Image>().material.SetTexture("_LoadingMask", radialEffect);
        else
            GetComponent<Image>().material.SetTexture("_LoadingMask", linearEffect);

        isRadial = !isRadial;

    }

    /// <summary>
    /// When the user makes click on the button, the material changes and starts
    /// to make the loading effect calling to a coroutine called Loading.
    /// </summary>
    public void Click()
    {
        if (!loading)
        {
            GetComponent<Image>().material.SetFloat("_TypeEffect", 0);
            StartCoroutine("Loading");
        }
    }

    /// <summary>
    /// It is a coroutine which makes the loading effect changing a value called
    /// _RangeEffect from the Material.
    /// When it finished, sets the material again to Glow Type Effect.
    /// </summary>
    /// <returns></returns>
    IEnumerator Loading()
    {
        float shaderValue = GetComponent<Image>().material.GetFloat("_RangeEffect");

        while (shaderValue > 0.0f)
        {
            shaderValue -= 0.01f;
            GetComponent<Image>().material.SetFloat("_RangeEffect", shaderValue);
            yield return new WaitForSeconds(0.01f);
        }

        GetComponent<Image>().material.SetFloat("_RangeEffect", 1.0f);
        GetComponent<Image>().material.SetFloat("_TypeEffect", 1);
    }

}
