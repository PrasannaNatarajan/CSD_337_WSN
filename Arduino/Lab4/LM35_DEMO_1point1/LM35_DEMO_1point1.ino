#include <Time.h>

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  analogReference(INTERNAL);
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
  unsigned long int voltPin = sensorValue*(double)(1100.0/1024.0);
  unsigned long int temp = (double)voltPin/10.0;
  time_t t = now();
  Serial.print("<");
  Serial.print(day(t));
  Serial.print("/");
  Serial.print(month(t));
  Serial.print("/");
  Serial.print(year(t));
  Serial.print(",");
  Serial.print(hour(t)%13);
  Serial.print(":");
  Serial.print(minute(t));
  if(hour(t)>=12)
    Serial.print("PM");
  else
    Serial.print("AM");
  Serial.print(",");
  Serial.print(temp);
  Serial.print(">");
  delay(10);        // delay in between reads for stability
}
