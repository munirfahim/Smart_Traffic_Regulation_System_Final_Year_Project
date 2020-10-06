/*
 Project Name: Smart Traffic Regulation System
 Author: Sirajum Munir Fahim
 Organization: American International University-Bangladesh
 For Course: Software Project 2
 Project Supervisor: Mohaimen-Bin-Noor
 All rights reserved.
 */

package com.example.smarttrafficsystemfyp;

import android.graphics.Bitmap;
import android.util.Base64;
import android.widget.Toast;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

public class Violation_Server {
    String violation_name;



    String violation_time;
    String violation_confidence;
    Bitmap violation_image;
    String location_name;
    String longitude;
    String latitude;
    String location_accuracy;
    String speed;
    String bus_device_id;
    String current_driver;

    public void send_violation(RequestQueue queue){

    }

    public String getStringImage(Bitmap bmp) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.JPEG, 100, baos);
        byte[] imageBytes = baos.toByteArray();
        String encodedImage = Base64.encodeToString(imageBytes, Base64.DEFAULT);
        return encodedImage;
    }

    public String getCurrent_driver() {
        return current_driver;
    }

    public void setCurrent_driver(String current_driver) {
        this.current_driver = current_driver;
    }

    public String getBus_device_id() {
        return bus_device_id;
    }

    public void setBus_device_id(String bus_device_id) {
        this.bus_device_id = bus_device_id;
    }

    public String getViolation_name() {
        return violation_name;
    }

    public void setViolation_name(String violation_name) {
        this.violation_name = violation_name;
    }

    public String getViolation_confidence() {
        return violation_confidence;
    }

    public void setViolation_confidence(String violation_confidence) {
        this.violation_confidence = violation_confidence;
    }

    public Bitmap getViolation_image() {
        return violation_image;
    }

    public void setViolation_image(Bitmap violation_image) {
        this.violation_image = violation_image;
    }

    public String getLocation_name() {
        return location_name;
    }

    public void setLocation_name(String location_name) {
        this.location_name = location_name;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLocation_accuracy() {
        return location_accuracy;
    }

    public void setLocation_accuracy(String location_accuracy) {
        this.location_accuracy = location_accuracy;
    }

    public String getSpeed() {
        return speed;
    }

    public void setSpeed(String speed) {
        this.speed = speed;
    }

    public String getViolation_time() {
        return violation_time;
    }

    public void setViolation_time(String violation_time) {
        this.violation_time = violation_time;
    }
}
