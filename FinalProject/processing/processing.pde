/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */

import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
char pressed;
char mode = 'T' ;

static int SCREEN_HEIGHT = 640;
static int SCREEN_WIDTH = 360;

void setup() 
{
  size(SCREEN_HEIGHT, SCREEN_WIDTH);
  // Create the font
  textFont(createFont("Georgia", 36));
  myPort = new Serial(this, "COM5", 9600);
  
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\t');         // read it and store it in val
  }
 //there is some delay between mode switches 
  //mode = key;
  //myPort.write(key);//sends the serial data to the arduino
  //catches the null 
  if(val == null){
     println("wait until null disappears");
  }
  else{
    printTime();
  }
  delay(1000);
  
}

void keyReleased(){
}

void printTime(){
  println(val);
  textSize(24);
  clear();
  text(val,100,50);
  fill(0,0,255);
}
/******to send int from processing to arduino**********/
/*
convert int to string in processing
then parse string back to int 
*/
