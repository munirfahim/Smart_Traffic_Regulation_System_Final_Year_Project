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
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.location.Location;
import android.media.ImageReader.OnImageAvailableListener;
import android.os.CountDownTimer;
import android.os.SystemClock;
import android.util.Size;
import android.util.TypedValue;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.smarttrafficsystemfyp.customview.OverlayView;
import com.example.smarttrafficsystemfyp.customview.OverlayView.DrawCallback;
import com.example.smarttrafficsystemfyp.env.BorderedText;
import com.example.smarttrafficsystemfyp.env.ImageUtils;
import com.example.smarttrafficsystemfyp.env.Logger;
import com.example.smarttrafficsystemfyp.tflite.Classifier;
import com.example.smarttrafficsystemfyp.tflite.TFLiteObjectDetectionAPIModel;
import com.example.smarttrafficsystemfyp.tracking.MultiBoxTracker;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * An activity that uses a TensorFlowMultiBoxDetector and ObjectTracker to detect and then track
 * objects.
 */
public class DetectorActivity extends CameraActivity implements OnImageAvailableListener {
  private static final Logger LOGGER = new Logger();

  // Configuration values for the prepackaged SSD model.
  private static final int TF_OD_API_INPUT_SIZE = 300;
  private static final boolean TF_OD_API_IS_QUANTIZED = true;
  private static final String TF_OD_API_MODEL_FILE = "detect.tflite";
  private static final String TF_OD_API_LABELS_FILE = "labelmap.txt";
  private static final DetectorMode MODE = DetectorMode.TF_OD_API;
  // Minimum detection confidence to track a detection.
  private static final float MINIMUM_CONFIDENCE_TF_OD_API = 0.7f;
  private static final boolean MAINTAIN_ASPECT = false;
  private static final Size DESIRED_PREVIEW_SIZE = new Size(320, 320);
  private static final boolean SAVE_PREVIEW_BITMAP = false;
  private static final float TEXT_SIZE_DIP = 10;
  OverlayView trackingOverlay;
  private Integer sensorOrientation;

  private Classifier detector;
  private boolean detected_flag = false;

  private TextView Violation_Error;

  private long lastProcessingTimeMs;
  private Bitmap rgbFrameBitmap = null;
  private Bitmap croppedBitmap = null;
  private Bitmap cropCopyBitmap = null;

  private boolean computingDetection = false;

  private long timestamp = 0;

  private Matrix frameToCropTransform;
  private Matrix cropToFrameTransform;

  private MultiBoxTracker tracker;

  private BorderedText borderedText;

  public Bitmap Current_Processing_Image;

  @Override
  public void onPreviewSizeChosen(final Size size, final int rotation) {
    final float textSizePx =
        TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP, TEXT_SIZE_DIP, getResources().getDisplayMetrics());
    borderedText = new BorderedText(textSizePx);
    borderedText.setTypeface(Typeface.MONOSPACE);

    tracker = new MultiBoxTracker(this);

    int cropSize = TF_OD_API_INPUT_SIZE;

    try {
      detector =
          TFLiteObjectDetectionAPIModel.create(
              getAssets(),
              TF_OD_API_MODEL_FILE,
              TF_OD_API_LABELS_FILE,
              TF_OD_API_INPUT_SIZE,
              TF_OD_API_IS_QUANTIZED);
      cropSize = TF_OD_API_INPUT_SIZE;
    } catch (final IOException e) {
      e.printStackTrace();
      LOGGER.e(e, "Exception initializing classifier!");
      Toast toast =
          Toast.makeText(
              getApplicationContext(), "Classifier could not be initialized", Toast.LENGTH_SHORT);
      toast.show();
      finish();
    }
//
    previewWidth = size.getWidth();
    previewHeight = size.getHeight();

//    previewWidth = size.getHeight();
//    previewHeight = size.getWidth();

    sensorOrientation = rotation - getScreenOrientation();
    LOGGER.i("Camera orientation relative to screen canvas: %d", sensorOrientation);

    LOGGER.i("Initializing at size %dx%d", previewWidth, previewHeight);
    rgbFrameBitmap = Bitmap.createBitmap(previewWidth, previewHeight, Config.ARGB_8888);
    croppedBitmap = Bitmap.createBitmap(cropSize, cropSize, Config.ARGB_8888);

    frameToCropTransform =
        ImageUtils.getTransformationMatrix(
            previewWidth, previewHeight,
            cropSize, cropSize,
            sensorOrientation, MAINTAIN_ASPECT);

    cropToFrameTransform = new Matrix();
    frameToCropTransform.invert(cropToFrameTransform);

    trackingOverlay = (OverlayView) findViewById(R.id.tracking_overlay);
    trackingOverlay.addCallback(
        new DrawCallback() {
          @Override
          public void drawCallback(final Canvas canvas) {
            tracker.draw(canvas);
            if (isDebug()) {
              tracker.drawDebug(canvas);
            }
          }
        });

    tracker.setFrameConfiguration(previewWidth, previewHeight, sensorOrientation);
  }

  @Override
  protected void processImage() {
    ++timestamp;
    final long currTimestamp = timestamp;
    trackingOverlay.postInvalidate();

    // No mutex needed as this method is not reentrant.
    if (computingDetection) {
      readyForNextImage();
      return;
    }
    computingDetection = true;
    LOGGER.i("Preparing image " + currTimestamp + " for detection in bg thread.");

    rgbFrameBitmap.setPixels(getRgbBytes(), 0, previewWidth, 0, 0, previewWidth, previewHeight);

    readyForNextImage();

    final Canvas canvas = new Canvas(croppedBitmap);
    canvas.drawBitmap(rgbFrameBitmap, frameToCropTransform, null);
    // For examining the actual TF input.
    if (SAVE_PREVIEW_BITMAP) {
      ImageUtils.saveBitmap(croppedBitmap);
    }

    runInBackground(
        new Runnable() {
          @Override
          public void run() {
            LOGGER.i("Running detection on image " + currTimestamp);
            final long startTime = SystemClock.uptimeMillis();
            final List<Classifier.Recognition> results = detector.recognizeImage(croppedBitmap);
            lastProcessingTimeMs = SystemClock.uptimeMillis() - startTime;

            cropCopyBitmap = Bitmap.createBitmap(croppedBitmap);
            final Canvas canvas = new Canvas(cropCopyBitmap);
            final Paint paint = new Paint();
            paint.setColor(Color.RED);
            paint.setStyle(Style.STROKE);
            paint.setStrokeWidth(2.0f);

            float minimumConfidence = MINIMUM_CONFIDENCE_TF_OD_API;
            switch (MODE) {
              case TF_OD_API:
                minimumConfidence = MINIMUM_CONFIDENCE_TF_OD_API;
                break;
            }

            final List<Classifier.Recognition> mappedRecognitions =
                new LinkedList<Classifier.Recognition>();

            for (final Classifier.Recognition result : results) {
              final RectF location = result.getLocation();
              if (location != null && result.getConfidence() >= minimumConfidence) {
                canvas.drawRect(location, paint);

                cropToFrameTransform.mapRect(location);

                result.setLocation(location);
                mappedRecognitions.add(result);
              }
            }

            tracker.trackResults(mappedRecognitions, currTimestamp);
              if(detected_flag == false) {
                final int size = tracker.getTrackedObjects().size();
                List<MultiBoxTracker.TrackedRecognition> detections = tracker.getTrackedObjects();
                for (int i = 0; i < size; i++) {
                  MultiBoxTracker.TrackedRecognition detection = detections.get(i);
                  if(atBusStop){
                    if (detection.title.contains("bus")||detection.title.contains("truck")||detection.title.contains("car")) {

                      Location location = current_location;
                      String location_name = current_location_name;
                      detection(detection.title, detection.detectionConfidence, cropCopyBitmap, location, location_name);

                    }
                  }
                  else{
                    if (detection.title.contains("person")) {
                        Location location = current_location;
                      String location_name = current_location_name;
                        detection(detection.title, detection.detectionConfidence, cropCopyBitmap, location, location_name);

                    }
                  }

                  //do something with i
                }
              }
            trackingOverlay.postInvalidate();

            computingDetection = false;

            runOnUiThread(
                new Runnable() {
                  @Override
                  public void run() {
//                    showFrameInfo(previewWidth + "x" + previewHeight);
//                    showCropInfo(cropCopyBitmap.getWidth() + "x" + cropCopyBitmap.getHeight());
//                    showInference(lastProcessingTimeMs + "ms");
                  }
                });
          }
        });
  }

  @Override
  protected int getLayoutId() {
    return R.layout.activity_main;
  }

  @Override
  protected Size getDesiredPreviewFrameSize() {
    return DESIRED_PREVIEW_SIZE;
  }

  // Which detection model to use: by default uses Tensorflow Object Detection API frozen
  // checkpoints.
  private enum DetectorMode {
    TF_OD_API;
  }

  @Override
  protected void setUseNNAPI(final boolean isChecked) {
    runInBackground(() -> detector.setUseNNAPI(isChecked));
  }

  @Override
  protected void setNumThreads(final int numThreads) {
    runInBackground(() -> detector.setNumThreads(numThreads));
  }

  public void detection(String detection_title, float detection_cof, Bitmap image, Location location, String location_name){
    detected_flag = true;
    Violation_Server new_violation = new Violation_Server();
    new_violation.setBus_device_id(BUS_DEVICE_ID);
    new_violation.setCurrent_driver(CURRENT_DRIVER);
    new_violation.setViolation_confidence(String.valueOf(detection_cof));
    new_violation.setViolation_name(detection_title);
    new_violation.setViolation_image(image);
    new_violation.setViolation_time(Calendar.getInstance().getTime().toString());
    new_violation.setLocation_name(location_name);
    new_violation.setLatitude(String.valueOf(location.getLatitude()));
    new_violation.setLongitude(String.valueOf(location.getLongitude()));
    if(current_location.hasSpeed()) {
      new_violation.setSpeed(String.valueOf(current_location.getSpeed()));
    }
    else
      new_violation.setSpeed("0");
    new_violation.setLocation_accuracy(String.valueOf(location.getAccuracy()));
    Violation_Error = findViewById(R.id.violation);
    Violation_Error.setText("Door Violation");
    new CountDownTimer(20000, 1000) {

      public void onTick(long millisUntilFinished) {

        Violation_Error.setText("Door violation, waiting " + millisUntilFinished / 1000);
        //here you can have your logic to set text to edittext
      }

      public void onFinish() {
        Violation_Error.setText("");
        detected_flag = false;
      }

    }.start();

//    send_Bus_Stop_Detection(new_violation);

  }

  private void send_Bus_Stop_Detection(Violation_Server violation){
    String imgstring = violation.getStringImage(violation.getViolation_image());

    RequestQueue queue = Volley.newRequestQueue(this);
    String url ="http://fahim.educationhost.cloud/SET_Violation.php";

    // Request a string response from the provided URL.
    StringRequest stringRequest = new StringRequest(Request.Method.POST, url,
            new Response.Listener<String>() {
              @Override
              public void onResponse(String response) {
                // Display the first 500 characters of the response string.
                //Violation_Error.setText(response);
              }
            }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError volleyError) {
        if (volleyError != null && volleyError.getMessage() != null) {
          //Toast.makeText(this, volleyError.getMessage(), Toast.LENGTH_LONG).show();
        } else {
          //Toast.makeText(CameraActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();

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
        params.put("imagecode", imgstring);
        params.put("time", violation.getViolation_time());
        params.put("confidence", violation.getViolation_confidence());
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
