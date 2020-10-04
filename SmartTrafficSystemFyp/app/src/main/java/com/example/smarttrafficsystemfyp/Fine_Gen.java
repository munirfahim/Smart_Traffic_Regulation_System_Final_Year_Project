/*
 Project Name: Smart Traffic Regulation System
 Author: Sirajum Munir Fahim
 Organization: American International University-Bangladesh
 For Course: Software Project 2
 Project Supervisor: Mohaimen-Bin-Noor
 All rights reserved.
 */

package com.example.smarttrafficsystemfyp;

public class Fine_Gen {
    String violation_type;
    String violation_time;

    public String getViolation_type() {
        return violation_type;
    }

    public void setViolation_type(String violation_type) {
        this.violation_type = violation_type;
    }

    public String getViolation_time() {
        return violation_time;
    }

    public void setViolation_time(String violation_time) {
        this.violation_time = violation_time;
    }
}
