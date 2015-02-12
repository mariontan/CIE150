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

void setup() 
{
  size(640, 360);
  // Create the font
  textFont(createFont("Georgia", 36));
  myPort = new Serial(this, "COM5", 9600);
  
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil(' ');         // read it and store it in val
  }
  myPort.write('L');//sends the serial data to the arduino
  //catches the null 
  if(val == null){
     println("hi");
  }
  else{
    printTime();
  }
  delay(1000);
}
void printTime(){
  println(val);
  textSize(24);
  clear();
  text(val,100,100);
  fill(0,0,255);
}
/******to send int from processing to arduino**********/
/*
convert int to string in processing
then parse string back to int 
*/
