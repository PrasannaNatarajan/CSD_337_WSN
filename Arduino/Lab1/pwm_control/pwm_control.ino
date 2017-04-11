void setup() {
//    pinMode(6, OUTPUT);
//  pinMode(9, OUTPUT);
  pinMode(3, OUTPUT);
  // put your setup code here, to run once:
  Serial.begin(9600);
}
int value=0;
void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available() > 0)
  {
    value = Serial.read();
    Serial.print(value);
    analogWrite(3,(255/9)*(value-48));
    delay(20);
  }
}
