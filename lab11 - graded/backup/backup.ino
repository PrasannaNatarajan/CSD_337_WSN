// Buttons : B1, B2,B3
// LEDs   :   Y1, R1, R2, G1, G2
// Sensor :   LDR
//

int R1=12;
int R2=9;
int G1=10;
int G2=13;
int Y1=11;
int btn1=7;
int btn2=6;
int btn3=8;

void setup() {
  Serial.begin(9600); // Start serial communication at 9600 bps
  pinMode(R1, OUTPUT); // Set pin as OUTPUT
  pinMode(R2, OUTPUT); // Set pin as OUTPUT
  pinMode(Y1, OUTPUT); // Set pin as OUTPUT
  pinMode(G1, OUTPUT); // Set pin as OUTPUT
  pinMode(G2, OUTPUT); // Set pin as OUTPUT
  pinMode(btn1, INPUT);
  pinMode(btn2, INPUT);
  pinMode(btn3, INPUT);
  Low(R1);
  Low(R2);
  Low(G1);
  Low(G2);
  Low(Y1);
  Serial.println("Sensor Calibration");
  delay(1000);
  Serial.println("Sensor Ready");
  
}


void loop() {
  
  int btn3v=getBtn(btn3);
  Serial.println(digitalRead(btn1));
  Serial.println(digitalRead(btn2));
  Serial.println(digitalRead(btn3));
  int btn2v=1;
  if(btn3v == 1)
  {
    High(G2); 
    int btn1v = getBtn(btn1);
    if(btn1v == 1)
    {
//      FIX THIS
      if (btn2v == 0)
      {
        High(Y1);
        if(analogRead(A0) > 700)
        {
          High(G1);
          Low(Y1);
          Low(R1);
        }
        else
        {
          High(R1);
          Low(Y1);
          Low(G1);
        }
//        TURN LDR OFF
        Low(Y1);
      }
      else
      {
        High(R2);
        btn2v = getBtn(btn2);
        while(btn2v == 0)
        {
          btn2v = getBtn(btn2);
        }
        Low(R2);
      }
    }
    Low(G2);
  }
  
  delay(100);

}

int getBtn(int a)
{
    return digitalRead(a);
}

void High(int a)
{
  digitalWrite(a, HIGH); // turn the LED on
}
void Low(int a)
{
  digitalWrite(a, LOW); // turn the LED on
}


