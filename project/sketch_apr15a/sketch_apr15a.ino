/*
 This is our submission of the source code of the project for Wireless Sensor Networks (CSD337), which consists of implementation of Slumbear, a sleep assistant.
 The code has been written in Arduino IDE and Processing.

 AUTHORS
 Atish Majumdar      : 1410110081
 Prasanna Natarajan  : 1410110298
 Vedant Chakravarthy : 1410110489
*/

// defining pins
#define ledPin 13
#define soundPin A0
#define lightPin A1
#define buttonPin 12
#define bufferSize 10
#define button2Pin 2

// global variables
int state = 0;
int sound = 0;
int light = 0;
int first = 0;
int threshold = 2;
int flag = 0;
int delayMultiplier = 1;

volatile int soundMedian;
volatile int temp=0;
void setup() {
  
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin,INPUT);digitalWrite(buttonPin,HIGH); // initialising button pin 
  pinMode(button2Pin,INPUT);digitalWrite(button2Pin,HIGH); // initialising button pin 
  // initialize the serial communication:
  Serial.begin(9600);
  state = digitalRead(buttonPin); // Reads the data from the serial port
  
  while(state == HIGH){
    state = digitalRead(buttonPin); // Reads the data from the serial port
    digitalWrite(ledPin, LOW); // Turn LED OFF
    Serial.println("OFF"); // Sending OFF signal to processing
    delay(10);
  }
   
  

  Serial.println("sensor Calibration... Takes upto 10s...");
  int i=0,sum=0;
  while(i<bufferSize){    
    sum+= analogRead(soundPin); //reading sound analog pin
    delay(1000);                // delay to account for single ADC
    i++;
  }
  soundMedian = sum/bufferSize;
  //Serial.println(digitalRead(button2Pin)); 
  attachInterrupt(0,calibrateISR,FALLING);  //interrupt to make the sensors calibrate
}


void loop() {
  
  //if(temp==1)while(1){Serial.println("here");}  //testing
  soundMedian = 590;
  digitalWrite(ledPin, HIGH);   //indicates that the machine in powered ON
  //Serial.println("sleep Monitor powered ON");Serial.flush();
  //Serial.println(soundMedian);Serial.flush();
  //Serial.println(digitalRead(button2Pin));Serial.flush();
  sound = analogRead(soundPin); //reading sound analog pin
  Serial.print("L");
  Serial.println(sound);Serial.flush();//sending sound value to get stored
  delay(1000);   // delay to account for single ADC
  light = analogRead(lightPin); //reading light analog pin
  Serial.print("S");
  Serial.println(light);Serial.flush();        //sending light value to get stored
  delay(1000);
  delayMultiplier = 1;
  int diff = abs(soundMedian - sound);
  //Serial.print("diff");
  //Serial.println(diff);Serial.flush(); 
  if(diff>threshold){ //if deviation from mid, then there is an increase in external noise
    //Serial.print("VP");
    //Serial.println(diff);Serial.flush();
    flag++;//delay(1000);
    delayMultiplier= 1;
  }
  else if(flag>10){ // if diff is less than threshold and volume from initial settings has been increased   
    //Serial.print("VD");
    //Serial.println(diff);Serial.flush();
    flag=0;//delay(1000);
    delayMultiplier=1;
  }
  
  //delay(100*delayMultiplier);   // delay to account 

  
}

//ISR to calibrate sensors
void calibrateISR(){
  int i=0,sum=0;
  while(i<bufferSize){
    sum += analogRead(soundPin); //reading sound analog pin
    delayMicroseconds(1000000);  // delay to account for single ADC
    i++;
  }
  soundMedian = sum/bufferSize;
  delayMicroseconds(10000000);
  temp =1;
}

