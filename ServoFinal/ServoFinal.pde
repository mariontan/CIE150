/*Marion Ivan Lim Tan*/
import processing.serial.*;
String ServoValue="";

HScrollbar Scroll;
Serial myPort;
void setup() {
  size(200, 300);
  noStroke();
  
  Scroll = new HScrollbar(0, height/2, width, 16, 16);
  myPort = new Serial(this, "COM5", 9600);
}

void draw() {
  background(255);
   
  ServoValue = str(int(Scroll.spos));
  myPort.write(ServoValue);
  myPort.write("\n");  
  Scroll.update();
  Scroll.display();
  text(ServoValue, 90,60);
  
  stroke(0);
  
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

 HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
/*
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
*/
