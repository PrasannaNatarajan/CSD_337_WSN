void setup() {
  // put your setup code here, to run once:
  pinMode(3,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int i;
  for(i=0;i<=255;i++){
    analogWrite(3,i);
    delay(20);
  }
  digitalWrite(3,LOW);
}
