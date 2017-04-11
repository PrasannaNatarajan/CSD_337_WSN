import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
int rectX, rectY;      // Position of square button
int rectSizeX = 100,rectSizeY = 40;     // Diameter of rect
color rectColor;
color rectHighlight;
boolean rectOver = false;


void setup() 
{
  size(800, 500);
  
  myPort = new Serial(this, "COM3", 9600);
  background(255);
  fill(0);
  text("BABY MONITOR",350,40);
  
  rectColor = color(10);
  rectHighlight = color(51);
  rectX = 650;
  rectY = 230;
}
int temp = 0;
void draw()
{
  update(mouseX, mouseY);
    if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSizeX, rectSizeY);
  fill(225);
  text("DONE",680,257);
  
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
    println(val);
  }
              // Set background to white
  if (val-'0' == 1) {              // If the serial value is 1,
    fill(255,0,0);                   // set fill to red
    rect(100, 50, 400, 400);
    //text("1",20,25);
    temp = 1;
  } 
  else if(temp!=1){     // If the serial value is not 0,
    fill(0);                 // set fill to light black
    rect(100, 50, 400, 400);
//text("0",20,20);
    
  }
  //rect(50, 50, 100, 100);
}

void update(int x, int y) {
if ( overRect(rectX, rectY, rectSizeX, rectSizeY) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  
  if (rectOver) {
    temp=0;            
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}