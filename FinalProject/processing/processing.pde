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
  size(200, 200);
   myPort = new Serial(this, "COM14", 9600);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil(' ');         // read it and store it in val
  }
  println(val);
  rect(50, 50, 100, 100);
  delay(1000);
}




