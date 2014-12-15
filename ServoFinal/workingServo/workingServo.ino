#include <Servo.h> 
 
Servo myservo;  

String strPos = "";                 

//int delayVal = 550;
void setup() 
{ 
  myservo.attach(9);  
  Serial.begin(9600);
  while (!Serial) {
  }
} 
 
void loop() 
{ 
  while (Serial.available() > 0) {
    int pos = Serial.read();
    if (isDigit(pos) == true) {
      strPos = strPos + (char)pos;
    } 
   if (pos == '\n') {
      myservo.write(strPos.toInt());              
      delay(15);      
      strPos = "";
   }
  }
}

/*int calculateDelay(int servoEndpt){
  int servoStartPt = myservo.read();
  return abs(servoStartPt-servoEndpt)*3;
}*/
