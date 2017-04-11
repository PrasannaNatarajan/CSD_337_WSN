
const int ledRedPin = 8;     // the number of the pushbutton pin
const int ledYellowPin =  9;      // the number of the LED pin
const int buttonPin = 2;
const int red2 = 12;
const int pir = 11;
const int green1 = 13;
volatile int which = 0;
void setup() {
  // put your setup code here, to run once
  
  // initialize the LED pin as an output:
  pinMode(ledRedPin, OUTPUT);
  pinMode(ledYellowPin, OUTPUT);
  pinMode(red2,OUTPUT);
  pinMode(green1,OUTPUT);
  pinMode(buttonPin,INPUT);digitalWrite(buttonPin,HIGH);
  digitalWrite(ledRedPin,LOW);
  digitalWrite(ledYellowPin,LOW);
  
  Serial.begin(9600);

  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  delay(1000);
  attachInterrupt(0,ledISR,FALLING);
}

void loop() {
  // put your main code here, to run repeatedly:
  unsigned long int tempValue = analogRead(A1);
  
  unsigned long int voltPin = tempValue*(double)(5000.0/1024.0);
  unsigned long int temp = (double)voltPin/10.0;
  //Serial.println(temp);
  int cr = 0,cy = 0;  //count number of blinks
  int y = 0;
  if(temp<30){
  digitalWrite(ledRedPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);  
  cr+=2;
  }
  else if(temp >30 && temp >40){
    
  digitalWrite(ledRedPin,HIGH);digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledRedPin,LOW);digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledRedPin,HIGH);digitalWrite(ledYellowPin,HIGH);
    cr+=4;cy+=4;y=1;
  }else if(temp>40){
    digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledYellowPin,HIGH);
  delay(100);
  digitalWrite(ledYellowPin,LOW);
  delay(100);
  digitalWrite(ledYellowPin,HIGH);
    cy+=6;y=1;
  }
  Serial.print(temp);
  Serial.print(" ");
  Serial.print(cr);
  
  Serial.print(" ");
  Serial.print(cy);
  
  Serial.print(" ");
  if(y==1)
  Serial.println("Y");
  else Serial.println("N");

  delay(2000);
}


void ledISR (){
  if(which ==0){
    int val = digitalRead(pir);
    if(val == 1){
      digitalWrite(red2,HIGH);
      delayMicroseconds(1000000);
      digitalWrite(red2,LOW);
    }
    which =1;
  }
  else if(which ==1){
    int ldrval = analogRead(A2);
    int tres = 700;
    if(ldrval>700){
      
      digitalWrite(green1,HIGH);
      delayMicroseconds(500000);
      
      digitalWrite(green1,LOW);
      delayMicroseconds(500000);
      
      digitalWrite(green1,HIGH);
      delayMicroseconds(500000);
      
      digitalWrite(green1,LOW);
      delayMicroseconds(500000);
      
      digitalWrite(green1,HIGH);
      delayMicroseconds(500000);
      
      digitalWrite(green1,LOW);
      delayMicroseconds(500000);
    }else{
      delayMicroseconds(1000000);
    }
    which = 2;
    
  }
  else{
    
  }
}


