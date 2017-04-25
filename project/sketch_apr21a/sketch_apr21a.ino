int led_pin = 13;
int val;
int ldr_val;
void setup() {
  // put your setup code here, to run once:
  pinMode(led_pin,OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = Serial.read();
  ldr_val = analogRead(A1);
  Serial.println(ldr_val);
  delay(100);
  if(val == '1'){
    digitalWrite(led_pin,HIGH);
  }
  if(val == '0'){
    digitalWrite(led_pin,LOW);
  }
}
/*OK
+ADDR:98d3:32:30bc9e
 */
