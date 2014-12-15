/**
 * Scrollbar. 
 * 
 * Move the scrollbars left and right to change the positions of the images. 
 */
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="seedTop.jpg,seedBottom.jpg"; */ 


import processing.serial.*;

Serial myPort;  // Create object from Serial class


HScrollbar hs1, hs2, hs3;  // Three scrollbars
int red,green,blue;

void setup() 
{
  // for graphics
  size(220, 200);
  hs1 = new HScrollbar(0, (height-20)*1/3, width, 16, 16);
  hs2 = new HScrollbar(0, (height-20)*2/3, width, 16, 16);
  hs3 = new HScrollbar(0, (height-20), width, 16, 16);
  
  // for Arduino/Serial Communication
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM5", 9600);
  
}

void draw() {
  
  
  // Get the position of the img1 scrollbar
  // and convert to a value to display the img1 image 
  //int img1Pos = (int) hs1.getPos()-width/2; //values with negative numbers
  red = int(hs1.getPos()); // 0 up to 180 
  green = int(hs2.getPos());
  blue = int(hs3.getPos());
  background(red, green, blue);
  
  myPort.write(red+","+green+","+blue);
  myPort.write("\n");
  fill(255);
  hs1.update();
  hs1.display();
  hs2.update();
  hs2.display();
  hs3.update();
  hs3.display();
  println(red);
  println(green);
  println(blue);
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
    spos = xpos + swidth/2 - sheight/2; // slider starts at  side
    //spos = xpos; // slider starts at left side
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
int redPin = 5;
int greenPin = 6;
int bluePin = 9;

int red = 0; 
int green = 0;
int blue = 0; 

void setup() {
  // put your setup code here, to run once:
   Serial.begin(9600);
  pinMode(redPin, OUTPUT); 
  pinMode(greenPin, OUTPUT); 
  pinMode(bluePin, OUTPUT); 

}

void loop() {
   while (Serial.available() > 0) {
    // Just reads ints from a string and stops when a non-int is read 
    // see documentation online for details
    red = Serial.parseInt(); 
    green = Serial.parseInt(); 
    blue = Serial.parseInt(); 

    
    if (Serial.read() == '\n') {
    // Just in case values exceed 255 or are negative ints 
      analogWrite(redPin, red);
      analogWrite(greenPin, green);
      analogWrite(bluePin, blue);
    }
  }
}
*/
