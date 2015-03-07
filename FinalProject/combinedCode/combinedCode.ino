/*******************************************
Wire Connections:
  RTC shield connections 
    SDA to a4; SCL to a5; GND to gnd; VCC to 5V
  Moisture Sensor
    Blue to A0; Black to gnd, Red to 5V/3.3V
  Temperature&Humidity Sensor
    Green to D4; Black to gnd; Red to 3.3V
  
Notes
  To reconfigure RTC:
    RTC.adjust(DateTime(__DATE__, __TIME__));
  Sensor values description in Moisture Sensor
    0  ~300     dry soil
    300~700     humid soil
    700~950     in water
    
Added and used libraries:
  RTClib
  DHTlib
********************************************/

#include <Wire.h>
#include <dht11.h>
#include "RTClib.h"


RTC_DS1307 RTC;
dht11 DHT;
#define DHT11_PIN 4

String Month;
String Date;
String Year;
String Hour;
String Minute;
String Second;

int wantedMoisture = 300;
int relayPin = 13;
//for checkSwitch function
int switchTimerPin = 6;
int switchMoisturePin = 7;
int switchChangeTimePin = 8;
char mode;   // for incoming serial data and switch value
char holder;
int tflag = 1;

const int nTimes = 2; //number of times to water the plant in a day
int waterTime[nTimes][3] = {{17,23,0},{17,24,0}}; //time to water; format: {h,m,s}


void checkSerial(){
  //Serial.begin(9600);
  if(Serial.available()>0){
    mode = Serial.read();
    //Serial.end();
  }
  else{
    mode = 't';
  }
}
void checkSwitch(){
  if(digitalRead(switchTimerPin) == HIGH){
    mode = 't';
  }
  else if(digitalRead(switchMoisturePin) == HIGH){
    tflag = 1;
    mode = 'm';
  }
  else if(digitalRead(switchChangeTimePin) == HIGH){
    mode = 'c';
  }
  else{
    Serial.println("Toggle switch correctly");
    mode = 'n';
  }
}

void timerCtrl(){
  DateTime now = RTC.now(); 
  //Converted to String for ease in transmission 
  Year = String(now.year());
  Month = String(now.month());
  Date = String(now.day());
  
  Hour = String(now.hour());
  Minute = String(now.minute());
  Second = String(now.second());
  
  Serial.println("Date: "+Month+'/'+Date+'/'+Year+"; Time: "+Hour+':'+Minute+':'+Second);   
  
  //compares if current time is equal then activate relay place times of day to water a plant
  for(int i = 0; i<nTimes; i++){
    if((waterTime[i][0]==now.hour())&&(waterTime[i][1]==now.minute())&&(waterTime[i][2]==now.second())){
      Serial.print(i);
      Serial.println(" time: Time matched");
      turnRelayON(10000);
    }
    else{
      Serial.print(i);
      Serial.println(" time: Time not matched");
    }
  }
}

void moistCtrl(){
  Serial.println(analogRead(0));
  if(analogRead(0) < wantedMoisture){
    Serial.println("More water needed");
    turnRelayON(10000);
  }
  else{
    Serial.println("Idle");
  }
}

void turnRelayON(int msWaterDuration){
  digitalWrite(relayPin,HIGH);//turn on relay 
  delay(msWaterDuration);//delay 3 seconds
  digitalWrite(relayPin, LOW);
}

void displayTempAndHum(){
  int chk = DHT.read(DHT11_PIN);
  Serial.print("Temperature: ");
  Serial.print(DHT.temperature,1);
  Serial.print(" deg celcius ; Humidity: ");
  Serial.print(DHT.humidity,1);
  Serial.println("%");
}

void setup(){
  Serial.begin(9600);
  Wire.begin();
  RTC.begin();
   
  if (!RTC.isrunning()) {
    Serial.println("RTC is NOT running!");
  }    
  pinMode(relayPin,OUTPUT);
  pinMode(switchTimerPin,INPUT);
  pinMode(switchMoisturePin,INPUT);
  pinMode(switchChangeTimePin,INPUT);
  pinMode(13,OUTPUT);
  
  digitalWrite(relayPin,LOW);
  digitalWrite(switchTimerPin,LOW);
  digitalWrite(switchMoisturePin,LOW);
  digitalWrite(switchChangeTimePin,LOW);
  digitalWrite(13,LOW);
}
 
void loop(){
  /*STRICTLY choose ONE between checkSerial and checkSwitch
    checkSerial = input through the Serial Monitor/Processing
    checkSwitch = input through the arduino for stand-alone processes
  */
  displayTempAndHum();
  //checkSerial();
  checkSwitch();
  //Serial.begin(9600);
  /*if(Serial.available()){
    mode = Serial.read();
    //Serial.end();
    holder = mode;
  }
  else{
    mode = holder;
  }*/
  
  if(mode == 't' ){
    tflag = 1;
    Serial.println("Timer Selected");
    timerCtrl();
    digitalWrite(13,HIGH);
    delay(1000);
    digitalWrite(13,LOW);
    Serial.println("Watering times");
         Serial.println("Water Time 1: "+String(waterTime[0][0])+":"+String(waterTime[0][1]));
         Serial.println("Water Time 2: "+String(waterTime[1][0])+":"+String(waterTime[1][1]));
    Serial.println("-------------------------------");
    Serial.print("\t");
   }
  
  else if(mode == 'c' && tflag){
         tflag = 0;
    Serial.println("Modify values");
   
   
         Serial.println("Please input first hour");
         delay(5000);
         waterTime[0][0]=Serial.parseInt();
         delay(2000);
         Serial.println("Please first minute");
         delay(5000);
         waterTime[0][1]=Serial.parseInt();
         delay(2000);
         Serial.println("Please second hour");
         delay(5000);
         waterTime[1][0]=Serial.parseInt();
         delay(2000);
         Serial.println("Please second minute");
         delay(5000);
         waterTime[1][1]=Serial.parseInt();
         delay(2000);

         Serial.println("Water Time 1: "+String(waterTime[0][0])+":"+String(waterTime[0][1]));
         Serial.println("Water Time 2: "+String(waterTime[1][0])+":"+String(waterTime[1][1]));
         
         Serial.println("Switch to other mode now");
         delay(5000);
    
   }
  
  else if(mode == 'm'){
    tflag = 1;
    Serial.println("Moisture Selected");
    //moistCtrl();
    Serial.println("-------------------------------");
  }
   
  delay(1000); 
}
