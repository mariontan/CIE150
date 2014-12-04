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
String direc = "";

Serial myPort;  // Create object from Serial class

String time,distance;
void setup() {
  size(500, 300);
  // Create the font
  textFont(createFont("Georgia", 36));
   
  myPort = new Serial(this, "COM4", 9600);
}

void draw() {
  
  if ( myPort.available() > 13) {  // If data is available,
   background(255); // Set background to black
   if(myPort.read() == 0xaa){//for error checking
       printDir("time(us) || distance(mm) ",130,130); 
       time = myPort.readString();
       printDir(time,180,160);
   }  
   printDir(time,180,160);
   myPort.clear();             //clear the serial port     
  }
  
}

void printDir(String dir, int x ,int y){
  println(dir);
  textSize(24);
  text(dir,x,y);
  fill(0,0,255);
}


/*
int GND1 = 13;
int GND2 = 12;
int RX = 11;
int TX = 10;
int VCC = 9;
int timeOut = 25000;
int time = 1;
float distance;
String timeS;
String distanceS;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(GND1, OUTPUT);
  pinMode(GND2, OUTPUT);
  pinMode(RX, INPUT);
  pinMode(TX, OUTPUT);
  pinMode(VCC, OUTPUT);
  
  digitalWrite(GND1, LOW);
  digitalWrite(GND2, LOW);
  digitalWrite(VCC, HIGH);
  digitalWrite(TX, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(TX, 0);
  delay(100);
  digitalWrite(TX, HIGH);
  delayMicroseconds(10);
  digitalWrite(TX, LOW);
  time = pulseIn(RX, 1, timeOut);
  distance = (time/2000.0)*334.0;
  
  timeS = String(time/2) + " || ";
  distanceS = String(distance);   
  if (time>0){
    
    Serial.write(0xaa);
    Serial.println(timeS + distanceS);
  }
delay(100);
}*/
