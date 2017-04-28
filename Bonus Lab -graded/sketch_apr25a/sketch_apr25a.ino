
void setup() {
  // put your setup code here, to run once:
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  delay(1000);
  setTime(1490705154 + 19800 +720 );
  
}

void loop() {
  // put your main code here, to run repeatedly:

}
