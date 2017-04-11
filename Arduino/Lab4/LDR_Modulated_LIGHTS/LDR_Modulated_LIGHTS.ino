
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  delay(1000);
  pinMode(3, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
}
int sensorMax=-1;
int sensorMin=10000;
// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A1);
  if(sensorValue > sensorMax)
    sensorMax = sensorValue;
  if(sensorValue < sensorMin)
    sensorMin = sensorValue;
  int brightness = ((float)(float)(sensorValue - sensorMin)/(float)(sensorMax-sensorMin))*255;
  analogWrite(3,brightness);
  analogWrite(5,brightness);
  analogWrite(6,brightness);
  // print out the value you read:
//  Serial.println(sensorValue);
  Serial.print("BRIGHTNESS : ");
  Serial.println(brightness);
  delay(10);        // delay in between reads for stability
}
