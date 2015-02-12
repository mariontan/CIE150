/*
RTC shield connections 
SDA to a4; SCL a5
*/

#include <Wire.h>
#include "RTClib.h"

String Month;
String Date;
String Year;

String Hour;
String Minute;
String Second;

int relayPin = 13;

int mode = 0;   // for incoming serial data
RTC_DS1307 RTC;

const int row = 2;
const int column = 2;
//{{hours, minutes}} put here times of day when to water plants
int waterTime[row][column] = {{16,6},{14,24}};

void checkSerial(){
  if (Serial.available() > 0) {
       // read the incoming byte:
        mode = Serial.parseInt();
       // say what you got:
        Serial.print("I received: ");
        Serial.println(mode);
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
    
    Serial.println(Year+'/'+Month+'/'+Date);
    Serial.println(Hour+':'+Minute+':'+Second);
    //processing stops reading when it sees a space
    Serial.print(' ');
       
    //comapres if curHour and curMinute are equal then activate relay place times of day to water a plant
    for(int i = 0; i<row; i++){
      if((waterTime[i][0]==now.hour())&&(waterTime[i][1]==now.minute())){
        turnRelayON();
        Serial.print("Hello");
      }
    }
    
}

void turnRelayON(){
    digitalWrite(relayPin,HIGH);//turn on relay 
    delay(1000);//delay 10 seconds
    digitalWrite(relayPin, LOW);
}
/*
//for moisture sensor
void moistCheck(){
  turnRealyON();
}
*/

void setup () {
    Serial.begin(9600);
    Wire.begin();
    RTC.begin();
 
    if (! RTC.isrunning()) {
      Serial.println("RTC is NOT running!");
      // following line sets the RTC to the date & time this sketch was compiled
      // uncomment it & upload to set the time, date and start run the RTC!
      //RTC.adjust(DateTime(__DATE__, __TIME__));
    }
        
    pinMode(relayPin,OUTPUT);
    digitalWrite(relayPin,LOW);
 
}
 
void loop () {
   checkSerial();
   if(mode == 1){
     timerCtrl();
   }
   else if(mode == 3){
     Serial.println("Hello world");
     delay(1000);
   } 
   delay(1000);
    
}






/**************Unused Code save for future use******************/
//while((startHour-endHour<=hrIntrvl)&&(startMinute-endMinute<=mntIntrvl)&&(startSec-endSec<=secIntrvl)==false){
 /* 
 
 //bug if time goes beyond 60s timer malfunctions, need a reset
    int hrIntrvl = 0;
    int mntIntrvl = 0;
    int secIntrvl = 0;

    startHour = now.hour();
    startMinute = now.minute();
    startSec = now.second();
    Serial.print(startHour, DEC);
    Serial.print(':');
    Serial.print(startMinute, DEC);
    Serial.print(':');
    Serial.print(startSec, DEC);
    Serial.println();
    delay(1000);
      if((endHour-startHour>=hrIntrvl)||(endMinute-startMinute>=mntIntrvl)||(endSec - startSec>=secIntrvl)){
       //if(endSec - startSec>=secIntrvl){
        timerStp = true;
      }
      //reset the start starttime
      if(endHour == 24||endMinute == 59||endSec == 59){
        Serial.println("reset");
        startHour = now.hour();
        startMinute = now.minute();
        startSec = now.second();
      }
 //getting unix time
 Serial.print(" since 1970 = ");
    Serial.print(now.unixtime());
    Serial.print("s = ");
    Serial.print(now.unixtime() / 86400L);
    Serial.println("d");
    
 // calculate a date which is 7 days and 30 seconds into the future
  DateTime future (now.unixtime() + 7 * 86400L + 30);
  
  Serial.print(" now + 7d + 30s: ");
  Serial.print(future.year(), DEC);
  Serial.print('/');
  Serial.print(future.month(), DEC);
  Serial.print('/');
  Serial.print(future.day(), DEC);
  Serial.print(' ');
  Serial.print(future.hour(), DEC);
  Serial.print(':');
  Serial.print(future.minute(), DEC);
  Serial.print(':');
  Serial.print(future.second(), DEC);
  Serial.println();*/
