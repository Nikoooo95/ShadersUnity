using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KnightColor : MonoBehaviour
{
    /// <summary>
    /// The material from the Knight
    /// </summary>
    private Material knightMaterial = null;

    /// <summary>
    /// Stores the material from the knight
    /// </summary>
    private void Awake()
    {
        knightMaterial = GetComponentInChildren<SkinnedMeshRenderer>().material;
    }

    /// <summary>
    /// Set the material's color to red
    /// </summary>
    public void SetRed()
    {
        knightMaterial.SetColor("_Color", Color.red);
    }

    /// <summary>
    /// Set the material's color to green
    /// </summary>
    public void SetGreen()
    {
        knightMaterial.SetColor("_Color", Color.green);
    }

    /// <summary>
    /// Set the material's color to cyan
    /// </summary>
    public void SetTeal()
    {
        knightMaterial.SetColor("_Color", Color.cyan);
    }

    /// <summary>
    /// Set the material's color to purple
    /// </summary>
    public void SetPurple()
    {
        knightMaterial.SetColor("_Color", new Color(0.62f, 0f, 1f));
    }

    /// <summary>
    /// Set the material's color to random color
    /// </summary>
    public void SetRandom()
    {
        knightMaterial.SetColor("_Color", new Color(RandValue(), RandValue(), RandValue(), 1.0f));
    }

    /// <summary>
    /// Generates a random value from 0f to 1f included.
    /// </summary>
    /// <returns></returns>
    private float RandValue()
    {
        return Random.Range(0.0f, 1.0f);
    }
}
