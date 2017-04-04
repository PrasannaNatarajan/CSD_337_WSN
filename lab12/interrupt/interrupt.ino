const int motionSensorPin = 2;
const int ledPin = 4;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(ledPin,OUTPUT);
  pinMode(motionSensorPin,INPUT);
  attachInterrupt(0,ledISR,FALLING);
}

void loop() {
  // put your main code here, to run repeatedly:
  int val = digitalRead(2);
  if(val == 1){
    Serial.println("Motion Detected");
  }
    
  else{
    Serial.println("No Motion");
  }
    
  delay(1000);
  digitalWrite(ledPin,LOW);
}

void ledISR(){

  digitalWrite(ledPin,HIGH);
  delayMicroseconds(1000000);
}

