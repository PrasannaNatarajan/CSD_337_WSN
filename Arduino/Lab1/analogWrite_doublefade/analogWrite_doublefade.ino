void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(3, OUTPUT);
  pinMode(6, OUTPUT);
//  pinMode(9, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  for(int i = 0; i<=255; i=i+5)
  {
    analogWrite(3,i);
    delay(20);
    analogWrite(6,255-i);
    delay(20);
  }
  digitalWrite(3,LOW);
  digitalWrite(6,HIGH);
}
