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
}
