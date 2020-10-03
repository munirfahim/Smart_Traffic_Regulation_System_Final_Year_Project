/*
*/

#include <ESP8266WiFi.h>     //Include Esp library
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>
//#include <WiFiClientSecureBearSSL.h> 
#include <SPI.h>
#include <MFRC522.h>        //include RFID library

#define SS_PIN D8 //RX slave select
#define RST_PIN D3
#define RedLed D1
#define BlueLed D2

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance.

/* Set these to your desired credentials. */
const char *ssid = "Virus";  //ENTER YOUR WIFI SETTINGS
const char *password = "17353453";

//Web/Server address to read/write from 
const char *host = "cstcs.000webhostapp.com";   //IP address of server

String getData ,Link;
String CardID="";
String DeviceID="123";

void setup() {
  delay(1000);
  Serial.begin(115200);
  SPI.begin();  // Init SPI bus
  mfrc522.PCD_Init(); // Init MFRC522 card

  WiFi.mode(WIFI_OFF);        //Prevents reconnection issue (taking too long to connect)
  delay(1000);
  WiFi.mode(WIFI_STA);        //This line hides the viewing of ESP as wifi hotspot
  
  WiFi.begin(ssid, password);     //Connect to your WiFi router
  Serial.println("");

  const uint8_t fingerprint[20] = {0x5b, 0xfb, 0xd1, 0xd4, 0x49, 0xd3, 0x0f, 0xa9, 0xc6, 0x40, 0x03, 0x34, 0xba, 0xe0, 0x24, 0x05, 0xaa, 0xd2, 0xe2, 0x01};
  
  Serial.print("Connecting to ");
  Serial.print(ssid);
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  //If connection successful show IP address in serial monitor
  Serial.println("");
  Serial.println("Connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());  //IP address assigned to your ESP

  pinMode(RedLed,OUTPUT);
  pinMode(BlueLed,OUTPUT);
  
}

void loop() {
  if(WiFi.status() != WL_CONNECTED){
    WiFi.disconnect();
    WiFi.mode(WIFI_STA);
    Serial.print("Reconnecting to ");
    Serial.println(ssid);
    WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    
  }
    Serial.println("");
    Serial.println("Connected");
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());  //IP address assigned to your ESP
    
  }
  
  //look for new card
   if ( ! mfrc522.PICC_IsNewCardPresent()) {
  return;//got to start of loop if there is no card present
 }
 // Select one of the cards
 if ( ! mfrc522.PICC_ReadCardSerial()) {
  return;//if read card serial(0) returns 1, the uid struct contians the ID of the read card.
 }

 for (byte i = 0; i < mfrc522.uid.size; i++) {
     CardID += mfrc522.uid.uidByte[i];
}
  
  HTTPClient http;    //Declare object of class HTTPClient
  
  //GET Data
  getData = "?Dev_ID="+DeviceID+"&L_No="+CardID;  //Note "?" added at front
  Link = "http://cstcs.000webhostapp.com/postdemo.php" + getData;
  
  http.begin(Link);
  
  int httpCode = http.GET();            //Send the request
  delay(10);
  String payload = http.getString();    //Get the response payload

  if (httpCode > 0) {
    Serial.printf("HTTP GET ... code: %d\n", httpCode);
    Serial.println(HTTP_CODE_OK);
    if (httpCode == HTTP_CODE_OK) {
      payload = http.getString();
    }
  } else {
    Serial.printf("HTTP GET failed, error: %s\n", http.errorToString(httpCode).c_str());
  }
  
  Serial.println(httpCode);   //Print HTTP return code
  Serial.println(payload);    //Print request response payload
  Serial.println("This is Card id:"+ CardID);     //Print Card ID
  
  if(payload == "invalid"){
    digitalWrite(RedLed,HIGH);
    Serial.println("red on");
    delay(500);  //Post Data at every 5 seconds
  }
  else if(payload == "login" || payload == "logout"){
    digitalWrite(BlueLed,HIGH);
    Serial.println("Blue on");
    delay(500);  //Post Data at every 5 seconds
  }
  delay(500);
  
  CardID = "";
  getData = "";
  Link = "";
  http.end();  //Close connection
  
  digitalWrite(RedLed,LOW);
  digitalWrite(BlueLed,LOW);
}
//=======================================================================
