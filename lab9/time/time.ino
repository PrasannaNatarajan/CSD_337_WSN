
//#include <TimeLib.h>
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  //analogReference(INTERNAL);
  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  delay(1000);
  //setTime(1490705154 + 19800 +720 );
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 1:
  //unsigned long int sensorValue = analogRead(A1);
  //unsigned long int voltPin = sensorValue*(double)(5000.0/1024.0);
  //unsigned long int temp = (double)voltPin/10.0;
  //Serial.write(temp);
  //delay(1000);
  //read the input on analog pin 2:
  int lightSensorValue = analogRead(A2);
  int lightVal = map(lightSensorValue,0,1023,0,255); 

  Serial.write(lightVal);
  delay(1000);
  

}
