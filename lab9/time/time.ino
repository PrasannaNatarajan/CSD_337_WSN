
#include <TimeLib.h>
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  analogReference(INTERNAL);
  //Serial.println("Sensor Calibration");
  delay(1000);
  //Serial.println("Sensor Ready");
  delay(1000);
  setTime(1490705154 + 19800 +720 );
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  unsigned long int sensorValue = analogRead(A1);
  // print out the value you read:
  unsigned long int voltPin = sensorValue*(double)(1100.0/1024.0);
  unsigned long int temp = (double)voltPin/10.0;
  
  time_t t = now();
  
  //Serial.println(timeStatus());
  //Serial.print("t is");
  //Serial.println(t);
  Serial.print("<");
  Serial.print(day(t));
  Serial.print("/");
  Serial.print(month(t));
  Serial.print("/");
  Serial.print(year(t));
  Serial.print(",");
  Serial.print(hour(t));
  Serial.print(":");
  Serial.print(minute(t));
  if(hour(t)>=12)
    Serial.print("PM");
  else
    Serial.print("AM");
  Serial.print(",");
  Serial.print(temp);
  Serial.println(">");
 // digitalClockDisplay();
  delay(1000);
}
void digitalClockDisplay(){
  // digital clock display of the time
  Serial.print(hour());
  printDigits(minute());
  printDigits(second());
  Serial.print(" ");
  Serial.print(day());
  Serial.print(" ");
  Serial.print(month());
  Serial.print(" ");
  Serial.print(year()); 
  Serial.println(); 
}

void printDigits(int digits) {
  // utility function for digital clock display: prints preceding colon and leading 0
  Serial.print(":");
  if(digits < 10)
    Serial.print('0');
  Serial.print(digits);
}
