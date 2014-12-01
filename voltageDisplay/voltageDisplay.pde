/**
 * Characters Strings. 
 *  
 * The character datatype, abbreviated as char, stores letters and 
 * symbols in the Unicode format, a coding system developed to support 
 * a variety of world languages. Characters are distinguished from other
 * symbols by putting them between single quotes ('P').<br />
 * <br />
 * A string is a sequence of characters. A string is noted by surrounding 
 * a group of letters with double quotes ("Processing"). 
 * Chars and strings are most often used with the keyboard methods, 
 * to display text to the screen, and to load images or files.<br />
 * <br />
 * The String datatype must be capitalized because it is a complex datatype.
 * A String is actually a class with its own methods, some of which are
 * featured below. 
 */

// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs font="Georgia.ttf"; */
import processing.serial.*;
char letter;
String words = "Begin...";

Serial myPort;  // Create object from Serial class
int val,val1,val2,val3,val4,val5;      // Data received from the serial port

void setup() {
  size(640, 360);
  // Create the font
  textFont(createFont("Georgia", 36));
   String portName = Serial.list()[0];
  myPort = new Serial(this, "COM5", 9600);
}

void draw() {
 if ( myPort.available() > 0) {  // If data is available,
    val1 = myPort.read();      // read it and store it in val
    val2 = myPort.read();
    val = (val1<<2)|val2;   // do this because serial can only read 10 volts
    val3 = myPort.read();      // read it and store it in val
    val4 = myPort.read();
    val5 = (val3<<2)|val4;   // do this because serial can only read 10 volts
    myPort.clear();
  }
  background(255); // Set background to black
  println(val);
  textSize(24);
  float fval = val*5.0/1023;
  String sval ="V= " + str(fval)+" volt";
  text(sval,100,100);
  fill(0,0,255);
  
  println(val5);
  textSize(24);
  float fval2 = val5*3.3/1023;
  String sval2 ="V= " + str(fval2)+" volts";
  text(sval2,150,150);
  fill(0,0,255);
 
}
/*
// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 17;                       // Switch connected to pin 4
int switchPin2 = 20;
void setup() {
  pinMode(switchPin, INPUT);             // Set pin A0 as an input
  pinMode(switchPin2, INPUT);             // Set pin A3 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  int val = analogRead(A0);
  //val = val>>2;//val = map(val,0,1023,0,255);// //val = val/4
  Serial.write(val>>2); //most significant 8 bit
  Serial.write(val& 0x3);// least significant 2 bit
  int val1 = analogRead(A3);
  Serial.write(val1>>2); //most significant 8 bit
  Serial.write(val1& 0x3);// least significant 2 bit
  delay(100);                            // Wait 100 milliseconds
}
*/
