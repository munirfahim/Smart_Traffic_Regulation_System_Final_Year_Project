/*
 Project Name: Smart Traffic Regulation System
 Author: Sirajum Munir Fahim
 Organization: American International University-Bangladesh
 For Course: Software Project 2
 Project Supervisor: Mohaimen-Bin-Noor
 All rights reserved.
 */

package com.example.smarttrafficsystemfyp.customview;

import com.example.smarttrafficsystemfyp.tflite.Classifier.Recognition;

import java.util.List;

public interface ResultsView {
  public void setResults(final List<Recognition> results);
}
