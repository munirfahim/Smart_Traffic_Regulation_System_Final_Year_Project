# Smart Traffic Regulation System

A multi-layer proof of concept project to regulate public transports in developing countries. Features: Arduino and RFID based driver and vehicle document verification, Location and speed tracking with Android GPS data and Google maps, Real-time object detection from android camera feed using TensorFlow Lite, REST API calls to connect all the devices with the central server and to communicate for verification, automated violation logging etc. 


## Hardware Setup and Project Recreation Steps

### License Verification Hardware Setup

![image](https://user-images.githubusercontent.com/57692222/140335626-56396891-f232-4239-9acf-0bc0688722d3.png)

* Step 1: First of all, all the components listed above needs to be assembled. Please refer to
the circuit diagram above to connect all of the components using a breadboard. The wiring
setup is:
  * SDA --- D8
  * SCK --- D5
  * MOSI --- D7
  * MISO --- D6
  * IRQ --- Not connected
  * GND --- GND
  * RST --- D3
  * 3.3V --- 3.3V
* Step 2: Connect the NodeMcu with a USB 2.0 cable and plug it in a computer. Arduino
IDE is needed to upload code on NodeMcu.
* Step 3: Add the ESP boards, RFID library and Firebase library to the Arduino IDE.
* Step 4: Create a Firebase real time database and copy the authentication and host
address/keys.
* Step 5: Please refer to the folder in the GitHub repository named RFID NodeMcu to find
the code needed. Use appropriate Wi-fi settings and Firebase host/authentications. 
* Step 6: Host web server on local machine or online. In this project, web server was hosted
on education host. Change the API URL to the appropriate domain/IP address.
* Step 7: Upload the code using WIFI and server details. Open serial port monitor and set
baud rate to 115200 to check connection status.
* Step 7: Create a MYSQL database, the database file is also included with the project files.
Change or create entries for the valid cards and device.
* Step 8: Configure connectDB.php using appropriate username and password.
* Step 9: Upload all contents of Web Codes folder on the web server. Specifically,
postdemo.php file as it works as the API between the database and the RFID module.
* Step 10: Test the device by scanning a valid card and check output on serial port. Serial
port should indicate if it is connected with the WIFI and also if the scan resulted in login
or logout. Green light should light up for successful card scan and red light for an invalid
card. 

### Android Device with Camera Setup

* Step 1: Use the codes in ‘SmartTrafficSystemFyp’ folder to open a project in android
studio.
* Step 2: Sync gradle file, all libraries, modules used should be downloaded automatically
along with TensorFlow lite model.
* Step 3: Model is pre-trained on coco dataset; other custom models can also be used by
replacing the model files.
* Step 4: Connect with the Firebase database created for the license module and connect the
android app with the database.
* Step 5: Upload the PHP files that has API in their name to the web server. These files
communicate with the android device. Change the URLs for all the Volley server requests.
* Step 6: Run the App on a Tablet with Android Q or higher installed. Some lower versions
up to 7.0 may work but they are not tested. 10.1” is the recommended tablet size. Nexus
10 Emulator can be used as AVD if real device is not available. 
*Step 7: Focus the camera vertically to the area that is needed to be used for detection. For
buses the door needs to be in full view and no passenger seats should be visible on camera
feed.
* Step 8: App should load the current driver and change driver when card is scanned. It will
display bus documents on top and driver documents in the middle. Also, current location
and camera feed should be displayed on both sides. Violations will trigger a message with
a counter. 

### Hardware Setup inside the bus
![image](https://user-images.githubusercontent.com/57692222/140337123-d8d71c3b-d32a-455b-9463-6bfe805f93d4.png)

As the above figure shows. The card reader or the license verification module will be beside the driver
and the android device will be visible to the driver and also the passengers. Camera will overlook the bus
door to monitor passenger pickup and offloading. 

### Central Monitoring System Setup

![image](https://user-images.githubusercontent.com/57692222/140337533-7fecbc0b-73e1-4c27-8423-34d7389f91b3.png)


* Step 1: Copy all the web codes to web directory.
* Step 2: Open home directory and login with admin username and password set on database
* Step 3: Check for driver logs for the bus device at Driver Log tab
* Step 4: Navigate to Bus Stop Violation tab to see bus stop violations. Click on the image
cell to get the violation image.
* Step 5: Navigate to Speed Violation tab to see speed violations. 



## System Features

### License Verification Module:

* Scan driving license with RFID reader
* Verify license with the central database
* Red light if the license is not valid for the bus
* Green light for successful login
* If driver is already logged into any other buses, then they are logged out from there
and logged into the current bus
* If the bus already had a driver logged in, He/she is logged out first and the current
driver is logged in
* Driver is coupled with the bus after logging in for any violations and also login logout
information with time is sent to be stored in the central database 

### Android Device Display:

* Bus documents is fetched from central database and displayed on screen, Error
message if the documents are not up to date
* Current driver information is displayed from the database and updates in real time if a
driver logs in or logs out.
* GPS data is processed with Google Maps API for real time location tracking
* Real time location data is displayed with speed and next bus stop information
* Camera feed of the door is displayed with detection state, indicating what type of
detection might be going on.
* Notification for any violation is displayed with a timer indicating when the detection
will start again. 


### Camera Module: 

* Collects real time video feed of the bus door for object detection
* Each frame is analyzed with pre-trained TF Lite object detection model trained on
coco dataset where 80 different types of objects can be recognized.
* An object is detected when the model has minimum 70% confidence.
 Detecting person type objects generate violation when the bus is on-route and not in a
bus stop
* Detecting car or bus, or truck type objects outside the bus door generate violation when
the bus is on a bus stop, which indicates the bus is not parked properly on a bus stop
beside a pavement. Rather it’s in the middle of a road.
* When a violation is detected, the image frame for the violation is captured with a
rectangular outline highlighting the detected object. This image along with the
confidence value of the detection, bus, driver, location info is sent to store in the central
traffic system.
* A timer of 20 seconds starts after a violation, and after the 20 seconds is passed, object
detection continues again. 

### Location Tracking with GPS and Google maps: 

* Collects real time location data using GPS, cellular network, WIFI connections
* Google Maps API fetches the longitude, latitude, accuracy and calculates speed of the
vehicle
* Geocode location converts longitude and latitude data to a geographical name
* Current geocode name is checked with stored bus stop location names stored in the
database as the route stops for the vehicle
* If the bus is in a bus stop, the location state is set to bus stop which dictates different
violation types. Works in vise versa when the bus is on-route
* Bus speed violation is detected if the bus’s speed is more than the speed limit, the
speed, location data, driver and bus info is sent to be stored in the central database.
* Detection pauses and resumes after 10 seconds, giving the driver some time to slow
down

### Admin/Central Traffic Police: 

* Login
* Check bus and driver login/logout information
* Check bus door violations
* Check speed violations

### Central Traffic Network (Database): 

* Checks, verifies and stores the fitness permit of the bus
* Checks, verifies and stores the route permit of the bus
* Checks, verifies and stores driving license information with vehicle type
* Bind the bus with driver’s license and logs the timing of login and logout
* Stores route stops for a bus root and assigns route to a bus
* Stores and manages all the violations 

## System Screenshots

### License Verification 
![image](https://user-images.githubusercontent.com/57692222/140338060-53976bde-90b1-4106-9343-3f16484a954a.png)

![image](https://user-images.githubusercontent.com/57692222/140338271-ca16b0e4-7efe-40c4-8d01-092d3c000867.png)

![image](https://user-images.githubusercontent.com/57692222/140338495-4a407e8a-9045-497f-982f-249677932e56.png)

![image](https://user-images.githubusercontent.com/57692222/140338692-e3855cca-4852-4f39-8c21-5c3cd61f1aff.png)

### Location Tracking and Speeding

![image](https://user-images.githubusercontent.com/57692222/140338815-916eb8e6-bad1-4e9f-a899-f3ac7bdeb797.png)

![image](https://user-images.githubusercontent.com/57692222/140338979-bc07d911-20d2-414c-8c2f-9e60b5368834.png)

### Camera module - Bus stop violation

![image](https://user-images.githubusercontent.com/57692222/140339232-0c26dc07-0d4b-442a-ba9a-fdef00e93dc2.png)

![image](https://user-images.githubusercontent.com/57692222/140339332-0228b3d2-b9bf-4f22-8ecc-a18614638756.png)

### Central Traffic Monitoring System

![image](https://user-images.githubusercontent.com/57692222/140339478-825b0cb6-2146-45cb-9f73-b0bee6866970.png)

![image](https://user-images.githubusercontent.com/57692222/140339764-7e045489-f702-4601-8001-17e3eef7cc19.png)

![image](https://user-images.githubusercontent.com/57692222/140340054-b7ab9cf6-71c4-41bc-b319-41ff5d2baf87.png)
