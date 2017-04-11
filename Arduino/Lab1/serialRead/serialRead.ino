void setup() {
    pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(3, OUTPUT);
  // put your setup code here, to run once:
  Serial.begin(9600);
}
char value='0';
void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available() > 0)
  {
    value = Serial.read();
    if(value=='g')
    {
      digitalWrite(6,LOW);
      digitalWrite(9,LOW);
      digitalWrite(3,LOW);

        digitalWrite(9,HIGH);
        delay(100);
        
    }
    else if(value=='r')
    {
      digitalWrite(6,LOW);
      digitalWrite(9,LOW);
      digitalWrite(3,LOW);

        digitalWrite(6,HIGH);
        delay(100);      
    }
    else if(value=='y')
    {
      digitalWrite(6,LOW);
      digitalWrite(9,LOW);
      digitalWrite(3,LOW);

      digitalWrite(3,HIGH);
      delay(100);
    }
    else{
      digitalWrite(6,LOW);
      digitalWrite(9,LOW);
      digitalWrite(3,LOW);
    }
    Serial.print("received: ");
    Serial.println(value,DEC);
  }
}
