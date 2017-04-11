
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  delay(1000);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  unsigned long int sensorValue = analogRead(A1);
  // print out the value you read:
  unsigned long int voltPin = sensorValue*(double)(5000.0/1024.0);
  unsigned long int temp = (double)voltPin/10.0;
  Serial.println(temp);
  delay(10);        // delay in between reads for stability
}
