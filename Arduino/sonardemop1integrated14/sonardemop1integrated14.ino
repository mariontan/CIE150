//fv +5V trig echo gnd gnd 
//echo = 12
//trig = 11
int i;
int echo = 12;
int trig = 11;
int gnd1 = 13;
int vcc1 = 10;
int ewan = 9;
int cnt = 1;
float f;
int to = 25000; //max time

void setup() {     
  Serial.begin(9600);
  Serial.println("starting...");
  pinMode(9,INPUT);//to connect to gnd
  pinMode(vcc1,OUTPUT);  //to connect to Vcc
  pinMode(echo, INPUT);      
  pinMode(trig, OUTPUT);   
  pinMode(gnd1, OUTPUT);
  digitalWrite(vcc1,HIGH); //to set to 5V, sonar VCC pin
  digitalWrite(gnd1,LOW); //to ground sonar gnd pin
  digitalWrite(trig,0); //init trig = 0
}

void loop() {
  digitalWrite(trig,0);
  delay(100); 
  digitalWrite(trig,HIGH);
  delayMicroseconds(10);
  digitalWrite(trig,LOW);
  cnt = pulseIn(echo,1,to); //measures t in us
  f= (cnt/2000.0)*346.4; //distance in mm at temp =25C

  
 
  //if (cnt > 0) {
  Serial.print(cnt);
  Serial.print("  us,  ");
  Serial.print(f);
  Serial.println(" mm     ");
  
  //}  
 
}



