int pushButton = 8;
int sound=3,motion=4;
int ledPin=7;

void setup() {
  Serial.begin(9600);
  pinMode(sound,INPUT);
  pinMode(motion,INPUT);
  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin,LOW);
}
int soundState,motionState;

void loop() {
  soundState = digitalRead(sound);
  motionState = digitalRead(motion);

  if((soundState == 1)&&(motionState == 1))
    digitalWrite(ledPin,HIGH);
  else
    digitalWrite(ledPin,LOW);
  Serial.println((soundState == 1)&&(motionState == 1));
  //Serial.print("Sound ");Serial.print(soundState);
  //Serial.print("\tMotion ");Serial.println(motionState);
  delay(100);
  
}
