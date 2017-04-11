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



/*
 * if (serialAvailable())
{
  char led;

  led = (char)serialRead();
  led -= (char)'0';

  if (led > -1 && led < THE_SIZE_OF_YOUR_PINARRAY)
      digitalWrite(pinArray[led], HIGH);
}



void draw(){

 if(keyPressed) {
   if (key == '0') {
     port.write ("0");
   }
   if (key == '1') {
     port.write ("1");
   }
   if (key == '2') {
     port.write ("2");
   }
   if (key == '3') {
     port.write ("3");
   }
   if (key == '4') {
     port.write ("4");
   }
   if (key == '5') {
     port.write ("5");
   }
 } 
 * 
 * 
 * /
 */

