using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonColor : MonoBehaviour
{
    /// <summary>
    /// Material that generates a Glow Effect
    /// </summary>
    [SerializeField]
    [Tooltip("Glow Effect Material")]
    Material glowMaterial = null;

    /// <summary>
    /// Material that generates a Linear Loading Effect
    /// </summary>
    [SerializeField]
    [Tooltip("Loading Linear Effect Material")]
    Material loadingLinearMaterial = null;

    /// <summary>
    /// Material that generates a Radial Loading Effect
    /// </summary>
    [SerializeField]
    [Tooltip("Loading Radial Effect Material")]
    Material loadingRadialMaterial = null;

    /// <summary>
    /// False: Is Linear Loading Effect. 
    /// True: Is Radial Loading Effect.
    /// </summary>
    bool isRadial = false;

    /// <summary>
    /// Makes the Glow Material as default
    /// </summary>
    public void Awake()
    {
        GetComponent<Image>().material = glowMaterial;
    }

    /// <summary>
    /// When the user makes click on the button, the material changes and starts
    /// to make the radial loading effect calling to a coroutine.
    /// </summary>
    public void Click()
    {
        if(!isRadial)
            GetComponent<Image>().material = loadingLinearMaterial;
        else
            GetComponent<Image>().material = loadingRadialMaterial;
        StartCoroutine("Loading");
    }

    /// <summary>
    /// It is a coroutine which makes the loading effect chaning a value called
    /// _RangeEffect from the Loading Material.
    /// When it finished, sets the material again to Glow.
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
        GetComponent<Image>().material = glowMaterial;

    }

    public void ChangeEffect()
    {
        isRadial = !isRadial;
    }

}
