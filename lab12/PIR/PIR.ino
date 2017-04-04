const int motionSensorPin = 2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(2,INPUT);
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
}
