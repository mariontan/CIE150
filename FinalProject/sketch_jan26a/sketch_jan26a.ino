#include <Wire.h>
#include "RTClib.h"

int startHour = 0;
int endHour = 0;
int startMinute = 0;
int endMinute = 0;
int startSec = 0;
int endSec = 0;

int hrIntrvl = 0;
int mntIntrvl = 0;
int secIntrvl = 5;

boolean timerStp = false;

RTC_DS1307 RTC;
 
void setup () {
    Serial.begin(57600);
    Wire.begin();
    RTC.begin();
 
  if (! RTC.isrunning()) {
    Serial.println("RTC is NOT running!");
    // following line sets the RTC to the date & time this sketch was compiled
    // uncomment it & upload to set the time, date and start run the RTC!
    //RTC.adjust(DateTime(__DATE__, __TIME__));
  }
 
}
 
void loop () {
    DateTime now = RTC.now();
        
    Serial.print(now.year(),DEC);
    Serial.print('/');
    Serial.print(now.month(),DEC);
    Serial.print('/');
    Serial.print(now.day(),DEC);
    Serial.print(' ');
    Serial.println();
    
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
    timerStp = false;
    
    while(timerStp == false){
      /***Do something here regarding the timer***/
      //needed so that now.second can get the second right now
      DateTime now = RTC.now();
      endHour = now.hour();
      endMinute = now.minute();
      endSec = now.second();
      
      Serial.println("endhour");
      Serial.print(endHour, DEC);
      Serial.print(':');
      Serial.print(endMinute, DEC);
      Serial.print(':');
      Serial.print(endSec, DEC);
      Serial.println();
      //bug if time goes beyond 60s timer malfunctions, need a reset
      if((endHour-startHour>=hrIntrvl)&&(endMinute-startMinute>=mntIntrvl)&&(endSec - startSec>=secIntrvl)){
        timerStp = true;
      }
      delay(1000);
    }
    
}
/**************Unused Code******************/
//while((startHour-endHour<=hrIntrvl)&&(startMinute-endMinute<=mntIntrvl)&&(startSec-endSec<=secIntrvl)==false){
 /* 
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
