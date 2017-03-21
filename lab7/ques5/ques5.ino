int incomingByte;
void setup() {
  // put your setup code here, to run once:
  pinMode(3,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
   // send data only when you receive data:
        if (Serial.available() > 0) {
                // read the incoming byte:
                incomingByte = Serial.read();
                //char c = Serial.read();
                // say what you got:
                Serial.print("I received: ");
                Serial.println(incomingByte,BIN);
                int i = Serial.parseInt(incomingByte)*((float)255/9);
                analogWrite(3,i);
        }
  
}
