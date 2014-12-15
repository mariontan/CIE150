// Hadrian Paulo Lim 112247
import processing.serial.*;
Serial myPort;  // Create object from Serial class
HScrollbar hsRed,hsGreen,hsBlue;
void setup() 
{
  // for graphics
  size(255, 200);
  hsRed = new HScrollbar(0, height*1/5, width, 16, 16);
  hsGreen = new HScrollbar(0, (height*2/3)+20, width, 16, 16);
  hsBlue = new HScrollbar(0, (height*3/5)+40, width, 16, 16);
  
  // for Arduino/Serial Communication
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM5", 9600);
  
}
void draw()
{
  int redValue = int(hsRed.spos);
  int greenValue = int(hsGreen.spos);
  int blueValue = int(hsBlue.spos);
  String rgbString = str(redValue)+","+str(greenValue)+","+str(blueValue);
  myPort.write(rgbString);
  myPort.write("\n");  
  println(rgbString);
  fill(redValue, greenValue, blueValue);
  hsRed.update();
  hsGreen.update();
  hsBlue.update();
  hsRed.display();
  hsGreen.display();
  hsBlue.display();
  
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
