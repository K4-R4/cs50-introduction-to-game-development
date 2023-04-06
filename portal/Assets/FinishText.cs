﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FinishText : MonoBehaviour
{
    private static Text text;
    // Start is called before the first frame update
    void Start()
    {
        text = GetComponent<Text>();
        text.color = new Color(0, 0, 0, 0);
    }

    // Update is called once per frame
    void Update()
    {

    }

    public static void ToggleOnText()
    {
        text.color = new Color(0, 0, 0, 1);
    }
}
