int rPin = 5;
int gPin = 6;
int bPin = 9;

int red = 0; 
int green = 0;
int blue = 0; 

void setup() {
  // put your setup code here, to run once:
   Serial.begin(9600);
  pinMode(rPin, OUTPUT); 
  pinMode(gPin, OUTPUT); 
  pinMode(bPin, OUTPUT); 

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
      analogWrite(rPin, red);
      analogWrite(gPin, green);
      analogWrite(bPin, blue);
    }
  }
}
