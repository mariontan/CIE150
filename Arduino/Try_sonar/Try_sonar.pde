/* Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
String A;
String B;


void setup() 
{
  size(300, 300);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val= myPort.read();         // read it and store it in val
    A=str(val);
    myPort.clear();
    
  }
  background(255); // set background to write
  println(A);
  textSize(24);
  //String sval = "distance = " + str(fval) + "mm";
  //text(sval,10,100); 
  //fill(0,0,255);

}
