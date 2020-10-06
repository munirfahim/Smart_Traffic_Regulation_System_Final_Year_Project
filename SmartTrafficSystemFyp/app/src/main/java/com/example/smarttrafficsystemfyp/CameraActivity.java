/*
 Project Name: Smart Traffic Regulation System
 Author: Sirajum Munir Fahim
 Organization: American International University-Bangladesh
 For Course: Software Project 2
 Project Supervisor: Mohaimen-Bin-Noor
 All rights reserved.
 */

package com.example.smarttrafficsystemfyp;

import android.Manifest;
import android.app.AlertDialog;
import android.app.Fragment;
import android.content.Context;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.hardware.Camera;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationManager;
import android.media.Image;
import android.media.Image.Plane;
import android.media.ImageReader;
import android.media.ImageReader.OnImageAvailableListener;
import android.os.Build;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Trace;
import android.util.Size;
import android.view.Surface;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.tasks.OnSuccessListener;

import com.example.smarttrafficsystemfyp.env.ImageUtils;
import com.example.smarttrafficsystemfyp.env.Logger;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;

import java.nio.ByteBuffer;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class CameraActivity extends AppCompatActivity
        implements OnImageAvailableListener,
        Camera.PreviewCallback,
        View.OnClickListener {
  public static final int DEFAULT_LOCATION_INTERVAL = 1000 * 10;
  private static final Logger LOGGER = new Logger();

  private static final int PERMISSIONS_REQUEST = 1;

  private static final String PERMISSION_CAMERA = Manifest.permission.CAMERA;
  public static final int DEFAULT_FASTEST_INTERVAL = 1000 * 5;
  public static final String BUS_DEVICE_ID = "123";
  public static final int SPEED_LIMIT = 30;
  private static final int PERMISSIONS_FINE_LOCATION = 99;
  protected int previewWidth = 0;
  protected int previewHeight = 0;
  private boolean debug = false;
  private Handler handler;
  private HandlerThread handlerThread;
  private boolean useCamera2API;
  private boolean isProcessingFrame = false;
  private byte[][] yuvBytes = new byte[3][];
  private int[] rgbBytes = null;
  private int yRowStride;
  private Runnable postInferenceCallback;
  private Runnable imageConverter;
  private TextView Bus_License, RP_exp, F_exp, D_Name, D_License, D_BG, D_Lic_Issue, Issue_Auth, Father_name, DOB, Vehicle_Type;
  private ImageView Driver_Image;

  private TextView Cur_loc, speed, next_stop, current_time, speed_violation, at_where;
  LocationRequest locationRequest;
  LocationCallback locationCallback;
  private boolean speedviolationdetected = false;

  FusedLocationProviderClient fusedLocationProviderClient;

  String[] route_stops = new String[20];
  public boolean atBusStop = false;
  public String CURRENT_DRIVER = "0";
  public Location current_location;
  public String current_location_name;


  @Override
  protected void onCreate(final Bundle savedInstanceState) {
    LOGGER.d("onCreate " + this);
    super.onCreate(null);
//    getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

    setContentView(R.layout.activity_main);
    if (hasPermission()) {
      setFragment();
    } else {
      requestPermission();
    }


    Bus_License = (TextView) findViewById(R.id.License);
    RP_exp = (TextView) findViewById(R.id.routepermit);
    F_exp = (TextView) findViewById(R.id.fitness);
    D_Name = (TextView) findViewById(R.id.drivername);
    D_License = (TextView) findViewById(R.id.driverLicense);
    D_BG = (TextView) findViewById(R.id.bloodgrp);
    D_Lic_Issue = (TextView) findViewById(R.id.lcsIssuedate);
    Issue_Auth = (TextView) findViewById(R.id.issueAuthority);
    Father_name = (TextView) findViewById(R.id.fatherName);
    DOB = (TextView) findViewById(R.id.address);
    Vehicle_Type = (TextView) findViewById(R.id.vehicletype);
    Driver_Image = (ImageView) findViewById(R.id.driver);

    Cur_loc = (TextView) findViewById(R.id.Current_Location);
    speed = (TextView) findViewById(R.id.Speed);
    next_stop = (TextView) findViewById(R.id.next_stop);
    speed_violation = (TextView) findViewById(R.id.speed_violation);
    at_where = (TextView) findViewById(R.id.at_where);


    //Getting Location

    locationRequest = new LocationRequest();

    locationRequest.setInterval(DEFAULT_LOCATION_INTERVAL);

    locationRequest.setFastestInterval(DEFAULT_FASTEST_INTERVAL);

    locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);

    locationCallback = new LocationCallback() {

      @Override
      public void onLocationResult(LocationResult locationResult) {
        super.onLocationResult(locationResult);

        Location location = locationResult.getLastLocation();
        updateUIValues(location);
      }
    };


    updateGPS();

    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
      // TODO: Consider calling
      //    ActivityCompat#requestPermissions
      // here to request the missing permissions, and then overriding
      //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
      //                                          int[] grantResults)
      // to handle the case where the user grants the permission. See the documentation
      // for ActivityCompat#requestPermissions for more details.
      return;
    }
    fusedLocationProviderClient.requestLocationUpdates(locationRequest, locationCallback, null);
    updateGPS();


    
    


    // Instantiate the RequestQueue.
    RequestQueue queue = Volley.newRequestQueue(this);
    String url = "http://fahim.educationhost.cloud/Get_Bus_API.php?Dev_ID=" + BUS_DEVICE_ID;


// Request a string response from the provided URL.
    StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
            new Response.Listener<String>() {
              @Override
              public void onResponse(String response) {
                // Display the first 500 characters of the response string.

                try {
                  JSONObject json = new JSONObject(response);
                  Bus_License.setText(json.getString("Issuing_Auth")+" "+json.getString("L_No"));
                  RP_exp.setText("Route Permit Expiry: "+json.getString("R_Perm_Exp"));
                  F_exp.setText("Fitness Expiry: "+json.getString("Fitness_Exp"));
                  if(json.getString("C_Driver")=="0"){
                    D_Name.setText("No Current Driver");
                    D_License.setText("Scan Driving License To Login");

                  }
                  else{
                    CURRENT_DRIVER = json.getString("C_Driver");
                    D_License.setText("License No: "+CURRENT_DRIVER);
                    String route_name = json.getString("route_name");
                    getRouteDetails(route_name);
                    getDriverDetails(CURRENT_DRIVER);

                    //Fetching Driver Details


                  }
                } catch (JSONException e) {
                  e.printStackTrace();
                }
              }
            }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError error) {

      }
    });

    // Add the request to the RequestQueue.
    queue.add(stringRequest);


  } //End of On create

  protected int[] getRgbBytes() {
    imageConverter.run();
    return rgbBytes;
  }

  protected int getLuminanceStride() {
    return yRowStride;
  }

  protected byte[] getLuminance() {
    return yuvBytes[0];
  }

  /** Callback for android.hardware.Camera API */
  @Override
  public void onPreviewFrame(final byte[] bytes, final Camera camera) {
    if (isProcessingFrame) {
      LOGGER.w("Dropping frame!");
      return;
    }

    try {
      // Initialize the storage bitmaps once when the resolution is known.
      if (rgbBytes == null) {
        Camera.Size previewSize = camera.getParameters().getPreviewSize();
        previewHeight = previewSize.height;
        previewWidth = previewSize.width;
        rgbBytes = new int[previewWidth * previewHeight];
        onPreviewSizeChosen(new Size(previewSize.width, previewSize.height), 90);
      }
    } catch (final Exception e) {
      LOGGER.e(e, "Exception!");
      return;
    }

    isProcessingFrame = true;
    yuvBytes[0] = bytes;
    yRowStride = previewWidth;

    imageConverter =
        new Runnable() {
          @Override
          public void run() {
            ImageUtils.convertYUV420SPToARGB8888(bytes, previewWidth, previewHeight, rgbBytes);
          }
        };

    postInferenceCallback =
        new Runnable() {
          @Override
          public void run() {
            camera.addCallbackBuffer(bytes);
            isProcessingFrame = false;
          }
        };
    processImage();
  }

  /** Callback for Camera2 API */
  @Override
  public void onImageAvailable(final ImageReader reader) {
    // We need wait until we have some size from onPreviewSizeChosen
    if (previewWidth == 0 || previewHeight == 0) {
      return;
    }
    if (rgbBytes == null) {
      rgbBytes = new int[previewWidth * previewHeight];
    }
    try {
      final Image image = reader.acquireLatestImage();

      if (image == null) {
        return;
      }

      if (isProcessingFrame) {
        image.close();
        return;
      }
      isProcessingFrame = true;
      Trace.beginSection("imageAvailable");
      final Plane[] planes = image.getPlanes();
      fillBytes(planes, yuvBytes);
      yRowStride = planes[0].getRowStride();
      final int uvRowStride = planes[1].getRowStride();
      final int uvPixelStride = planes[1].getPixelStride();

      imageConverter =
          new Runnable() {
            @Override
            public void run() {
              ImageUtils.convertYUV420ToARGB8888(
                  yuvBytes[0],
                  yuvBytes[1],
                  yuvBytes[2],
                  previewWidth,
                  previewHeight,
                  yRowStride,
                  uvRowStride,
                  uvPixelStride,
                  rgbBytes);
            }
          };

      postInferenceCallback =
          new Runnable() {
            @Override
            public void run() {
              image.close();
              isProcessingFrame = false;
            }
          };

      processImage();
    } catch (final Exception e) {
      LOGGER.e(e, "Exception!");
      Trace.endSection();
      return;
    }
    Trace.endSection();
  }

  @Override
  public synchronized void onStart() {
    LOGGER.d("onStart " + this);
    super.onStart();
  }

  @Override
  public synchronized void onResume() {
    LOGGER.d("onResume " + this);
    super.onResume();

    handlerThread = new HandlerThread("inference");
    handlerThread.start();
    handler = new Handler(handlerThread.getLooper());
  }

  @Override
  public synchronized void onPause() {
    LOGGER.d("onPause " + this);

    handlerThread.quitSafely();
    try {
      handlerThread.join();
      handlerThread = null;
      handler = null;
    } catch (final InterruptedException e) {
      LOGGER.e(e, "Exception!");
    }

    super.onPause();
  }

  @Override
  public synchronized void onStop() {
    LOGGER.d("onStop " + this);
    super.onStop();
  }

  @Override
  public synchronized void onDestroy() {
    LOGGER.d("onDestroy " + this);
    super.onDestroy();
//    if (status == true)
//      unbindService();
  }

  protected synchronized void runInBackground(final Runnable r) {
    if (handler != null) {
      handler.post(r);
    }
  }

  @Override
  public void onRequestPermissionsResult(
          final int requestCode, final String[] permissions, final int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    if (requestCode == PERMISSIONS_REQUEST) {
      if (allPermissionsGranted(grantResults)) {
        setFragment();
      } else {
        requestPermission();
      }
    }
    if(requestCode == PERMISSIONS_FINE_LOCATION){
      if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
        updateGPS();
      }
      else{
        Toast.makeText(this, "Permission Denied", Toast.LENGTH_LONG).show();
        finish();
      }
    }
  }

  private static boolean allPermissionsGranted(final int[] grantResults) {
    for (int result : grantResults) {
      if (result != PackageManager.PERMISSION_GRANTED) {
        return false;
      }
    }
    return true;
  }

  private boolean hasPermission() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      return checkSelfPermission(PERMISSION_CAMERA) == PackageManager.PERMISSION_GRANTED;
    } else {
      return true;
    }
  }

  private void requestPermission() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (shouldShowRequestPermissionRationale(PERMISSION_CAMERA)) {
        Toast.makeText(
                CameraActivity.this,
                "Camera permission is required for this demo",
                Toast.LENGTH_LONG)
            .show();
      }
      requestPermissions(new String[] {PERMISSION_CAMERA}, PERMISSIONS_REQUEST);
    }
  }

  // Returns true if the device supports the required hardware level, or better.
  private boolean isHardwareLevelSupported(
          CameraCharacteristics characteristics, int requiredLevel) {
    int deviceLevel = characteristics.get(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL);
    if (deviceLevel == CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL_LEGACY) {
      return requiredLevel == deviceLevel;
    }
    // deviceLevel is not LEGACY, can use numerical sort
    return requiredLevel <= deviceLevel;
  }

  private String chooseCamera() {
    final CameraManager manager = (CameraManager) getSystemService(Context.CAMERA_SERVICE);
    try {
      for (final String cameraId : manager.getCameraIdList()) {
        final CameraCharacteristics characteristics = manager.getCameraCharacteristics(cameraId);

        // We don't use a front facing camera in this sample.
        final Integer facing = characteristics.get(CameraCharacteristics.LENS_FACING);
        if (facing != null && facing == CameraCharacteristics.LENS_FACING_FRONT) {
          continue;
        }

        final StreamConfigurationMap map =
            characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);

        if (map == null) {
          continue;
        }

        // Fallback to camera1 API for internal cameras that don't have full support.
        // This should help with legacy situations where using the camera2 API causes
        // distorted or otherwise broken previews.
        useCamera2API =
            (facing == CameraCharacteristics.LENS_FACING_EXTERNAL)
                || isHardwareLevelSupported(
                    characteristics, CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL_FULL);
        LOGGER.i("Camera API lv2?: %s", useCamera2API);
        return cameraId;
      }
    } catch (CameraAccessException e) {
      LOGGER.e(e, "Not allowed to access camera");
    }

    return null;
  }

  protected void setFragment() {
    String cameraId = chooseCamera();

    Fragment fragment;
    if (useCamera2API) {
      CameraConnectionFragment camera2Fragment =
          CameraConnectionFragment.newInstance(
              new CameraConnectionFragment.ConnectionCallback() {
                @Override
                public void onPreviewSizeChosen(final Size size, final int rotation) {
                  previewHeight = size.getHeight();
                  previewWidth = size.getWidth();
                  CameraActivity.this.onPreviewSizeChosen(size, rotation);
                }
              },
              this,
              getLayoutId(),
              getDesiredPreviewFrameSize());

      camera2Fragment.setCamera(cameraId);
      fragment = camera2Fragment;
    } else {
      fragment =
          new LegacyCameraConnectionFragment(this, getLayoutId(), getDesiredPreviewFrameSize());
    }

    getFragmentManager().beginTransaction().replace(R.id.container, fragment).commit();
  }

  protected void fillBytes(final Plane[] planes, final byte[][] yuvBytes) {
    // Because of the variable row stride it's not possible to know in
    // advance the actual necessary dimensions of the yuv planes.
    for (int i = 0; i < planes.length; ++i) {
      final ByteBuffer buffer = planes[i].getBuffer();
      if (yuvBytes[i] == null) {
        LOGGER.d("Initializing buffer %d at size %d", i, buffer.capacity());
        yuvBytes[i] = new byte[buffer.capacity()];
      }
      buffer.get(yuvBytes[i]);
    }
  }

  public boolean isDebug() {
    return debug;
  }

  protected void readyForNextImage() {
    if (postInferenceCallback != null) {
      postInferenceCallback.run();
    }
  }

  protected int getScreenOrientation() {
    switch (getWindowManager().getDefaultDisplay().getRotation()) {
      case Surface.ROTATION_270:
        return 270;
      case Surface.ROTATION_180:
        return 180;
      case Surface.ROTATION_90:
        return 90;
      default:
        return 0;
    }
  }

  @Override
  public void onClick(View v) {
  }

  protected abstract void processImage();

  protected abstract void onPreviewSizeChosen(final Size size, final int rotation);

  protected abstract int getLayoutId();

  protected abstract Size getDesiredPreviewFrameSize();

  protected abstract void setNumThreads(int numThreads);

  protected abstract void setUseNNAPI(boolean isChecked);


  private void getDriverDetails(String Driver){
    RequestQueue queue = Volley.newRequestQueue(this);
    String url ="http://fahim.educationhost.cloud/Get_Driver_API.php?Driver="+Driver;

    // Request a string response from the provided URL.
    StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
            new Response.Listener<String>() {
              @Override
              public void onResponse(String response) {
                // Display the first 500 characters of the response string.

                try {
                  JSONObject json = new JSONObject(response);
                  D_Name.setText(json.getString("Name"));
                  D_BG.setText("Blood Group: "+json.getString("BloodGroup"));
                  D_Lic_Issue.setText("License Issue Date: "+json.getString("L_Issue_D"));
                  Issue_Auth.setText("Issuing Authority: "+json.getString("Issuing_Auth"));
                  Father_name.setText("Father's Name: "+json.getString("F_Name"));
                  DOB.setText("Date of Birth: "+json.getString("DOB"));
                  Vehicle_Type.setText("License Vehicle Type: "+json.getString("V_Type"));

                  //Getting Driver Image
                  String imageUri = "http://fahim.educationhost.cloud/image/"+json.getString("Image");
                  Picasso.get().load(imageUri).into(Driver_Image);


                } catch (JSONException e) {
                  e.printStackTrace();
                }
              }
            }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError error) {

      }
    });

    // Add the request to the RequestQueue.
    queue.add(stringRequest);
  }

  private void getRouteDetails(String Route){
    RequestQueue queue = Volley.newRequestQueue(this);
    String url ="http://fahim.educationhost.cloud/GET_Route_API.php?Route="+Route;



    // Request a string response from the provided URL.
    StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
            new Response.Listener<String>() {
              @Override
              public void onResponse(String response) {
                // Display the first 500 characters of the response string.

                try {
                  JSONObject json = new JSONObject(response);
                  for(int i=0;i<7;i++){

                    if(json.getString("Stop "+String.valueOf(i+1))!=null)
                    route_stops[i] = json.getString("Stop "+String.valueOf(i+1));
                    next_stop.setText("Next Stop: "+ route_stops[0]);

                  }

                } catch (JSONException e) {
                  e.printStackTrace();
                }
              }
            }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError error) {

      }
    });

    // Add the request to the RequestQueue.
    queue.add(stringRequest);
  }

  public void updateGPS(){
    fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(CameraActivity.this);
    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
      fusedLocationProviderClient.getLastLocation().addOnSuccessListener(this, new OnSuccessListener<Location>() {
        @Override
        public void onSuccess(Location location) {
          if(location !=null){
            updateUIValues(location);
          }



        }
      });
    }
    else{
      if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.M){
        requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSIONS_FINE_LOCATION);
      }
    }
  }

  private void updateUIValues(Location location){
    Geocoder geocoder = new Geocoder(CameraActivity.this);

    try{
      List<Address> addresses = geocoder.getFromLocation(location.getLatitude(), location.getLongitude(), 1);
      Cur_loc.setText("Current location: "+ addresses.get(0).getAddressLine(0));
      current_location = location;
      current_location_name = addresses.get(0).getAddressLine(0);
      for(int i=0; route_stops[i]!=null; i++){
        if(addresses.get(0).getAddressLine(0).contains(route_stops[i])){
            atBusStop = true;
            next_stop.setText("Next Stop: " + route_stops[i+1]);
            at_where.setText("At Bus Stop, People allowed on Camera view, Stop safely before opening door");
            at_where.setTextColor(Color.GREEN);
          }
        else if(addresses.get(0).getAddressLine(0).contains("Bus Stop")||addresses.get(0).getAddressLine(0).contains("Bus Stand")||addresses.get(0).getAddressLine(0).contains("Bus Station")){
          atBusStop = true;
          at_where.setText("At Bus Stop, People allowed on Camera view, Stop safely before opening door");
          at_where.setTextColor(Color.GREEN);
        }
        else {
          atBusStop = false;
          at_where.setText("On-Route, No one allowed on Camera View");
          at_where.setTextColor(Color.RED);

        }
      }
    }
    catch (Exception e){
      Cur_loc.setText("Current Location: "+ String.valueOf(location.getLatitude())+" "+ String.valueOf(location.getLongitude()));
      atBusStop = false;
      at_where.setText("On-Route, No one allowed on Camera View");
      at_where.setTextColor(Color.RED);
    }



      if(location.hasSpeed()){
        speed.setText("Speed: "+String.valueOf(location.getSpeed()));
        if(location.getSpeed()>SPEED_LIMIT && speedviolationdetected==false){
          speed_violation();
        }
      }
      else{
        speed.setText("Speed: Unavailable");
      }



  }

  public void speed_violation(){
    speedviolationdetected = true;

    Violation_Server new_violation = new Violation_Server();
    new_violation.setBus_device_id(BUS_DEVICE_ID);
    new_violation.setCurrent_driver(CURRENT_DRIVER);
    new_violation.setViolation_name("Speed_Violation");
    new_violation.setViolation_time(Calendar.getInstance().getTime().toString());
    new_violation.setLocation_name(current_location_name);
    new_violation.setLatitude(String.valueOf(current_location.getLatitude()));
    new_violation.setLongitude(String.valueOf(current_location.getLatitude()));
    new_violation.setSpeed(String.valueOf(current_location.getSpeed()));
    new_violation.setLocation_accuracy(String.valueOf(current_location.getAccuracy()));

    speed_violation.setText("Speed Violation Detected");
    new CountDownTimer(10000, 1000) {

      public void onTick(long millisUntilFinished) {

        speed_violation.setText("Speed violation, waiting " + millisUntilFinished / 1000);
        //here you can have your logic to set text to edittext
      }

      public void onFinish() {
        speed_violation.setText("");
        speedviolationdetected = false;
      }

    }.start();

    send_Speed_Detection(new_violation);
  }

  private void send_Speed_Detection(Violation_Server violation){
    RequestQueue queue = Volley.newRequestQueue(this);
    String url ="http://fahim.educationhost.cloud/SET_Violation.php";

    // Request a string response from the provided URL.
    StringRequest stringRequest = new StringRequest(Request.Method.POST, url,
            new Response.Listener<String>() {
              @Override
              public void onResponse(String response) {
                // Display the first 500 characters of the response string.
                Toast.makeText(CameraActivity.this, response, Toast.LENGTH_LONG).show();


              }
            }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError volleyError) {
        if (volleyError != null && volleyError.getMessage() != null) {
          //Toast.makeText(this, volleyError.getMessage(), Toast.LENGTH_LONG).show();
        } else {
          //Toast.makeText(this, "Something went wrong", Toast.LENGTH_LONG).show();

        }
      }
    }){
      @Override
      protected Map<String, String> getParams() {
        Map<String, String> params = new HashMap<String, String>();
        params.put("violation_name", violation.getViolation_name());
        params.put("bus_id", violation.getBus_device_id());
        params.put("driver_id", violation.getCurrent_driver());
        params.put("latitude", violation.getLatitude());
        params.put("loc_accuracy", violation.getLocation_accuracy());
        params.put("longitude", violation.getLongitude());
        params.put("loc_name", violation.getLocation_name());
        params.put("speed", violation.getSpeed());
        params.put("time", violation.getViolation_time());
        return params;
      }
    };

    RetryPolicy mRetryPolicy = new DefaultRetryPolicy(
            0,
            DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
            DefaultRetryPolicy.DEFAULT_BACKOFF_MULT);

    stringRequest.setRetryPolicy(mRetryPolicy);

    // Add the request to the RequestQueue.
    queue.add(stringRequest);
  }

}
