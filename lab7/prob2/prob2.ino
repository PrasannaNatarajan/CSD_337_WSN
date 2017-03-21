void setup() {
  // put your setup code here, to run once:
  pinMode(3,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  static int i=0;
  analogWrite(3,(i++)%256);
  delay(20);
  digitalWrite(3,LOW);
}
