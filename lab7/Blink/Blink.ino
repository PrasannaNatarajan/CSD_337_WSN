/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
*/


// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(13, OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(11,OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  int i;
  for(i=0;i<3;i++){
    digitalWrite(11+i, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);                       // wait for a second
    digitalWrite(11+i, LOW);    // turn the LED off by making the voltage LOW
    delay(100);
  }
}
