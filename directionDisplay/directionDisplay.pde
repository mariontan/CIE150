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


void setup() {
  size(640, 360);
  // Create the font
  textFont(createFont("Georgia", 36));
   
  myPort = new Serial(this, "COM14", 9600);
}

void draw() {
  
  if ( myPort.available() > 0) {  // If data is available,
   background(255); // Set background to black
   if(myPort.read() == 0xaa){
     direc = "down";
     printDir(direc);
    
    }  
  else if(myPort.read() == 0xbb){
    direc = "left";
    printDir(direc);
    }
  else if(myPort.read() == 0xcc){
    direc = "right";
    printDir(direc);
    }
  else if(myPort.read() == 0xdd){
    direc = "up";
    printDir(direc);
    }
    myPort.clear();              //clear the serial port     
  }
  printDir(direc);
}

void printDir(String dir){
  println(dir);
  textSize(24);
  text(dir,150,150);
  fill(0,0,255);
}


/*
int gnd = 10;
int vcc = 11;
void setup() {                
  pinMode(8, INPUT);    //pin B
  pinMode(9, INPUT);   //pin A
  pinMode(10,OUTPUT);  //pin gnd
  pinMode(11,OUTPUT);  //pin Vcc 
  delay(100);
  digitalWrite(10, LOW); //set to gnd
  digitalWrite(11, HIGH); //set to Vcc 
  Serial.begin(9600);   
}

void loop() {
  int x1 = digitalRead(8);
  int x2 = digitalRead(9);
  int x = x2*2 + x1;
  Serial.println(x);
  switch (x) {
  case 0:    // your hand is on the sensor
    Serial.write(0xaa);//down
    break;
  case 1:    // your hand is close to the sensor
    Serial.write(0xbb);//left
    break;
  case 2:    // your hand is a few inches from the sensor
    Serial.write(0xcc);//right
    break;
  case 3:    // your hand is nowhere near the sensor
    Serial.write(0xdd);//up
    break;
  } 
  
  //delay(100);
}*/
