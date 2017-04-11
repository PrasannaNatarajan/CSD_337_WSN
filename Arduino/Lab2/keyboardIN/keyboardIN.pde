import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

int rectX, rectY;      // Position of square button
int rectSize = 90;     // Diameter of rect
color rectColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
PFont f;

void setup() {
  size(640, 360);
  rectColor = color(0);
  rectHighlight = color(51);
  //baseColor = color(102);
  currentColor = baseColor;
  rectX = 500;
  rectY = 50;
  ellipseMode(CENTER);
  myPort = new Serial(this, "COM7", 9600);

}

void draw() {
  update(mouseX, mouseY);
  background(currentColor);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  
  rect(100, rectY, rectSize*3, rectSize);
  fill(255);
  //text("THIS TEXT",140,rectY+40,100,100);
  
  text(realDC,240,200,100,100);
  text(dcOut,140,rectY+40,100,100);

}
String dcOut="",realDC="DC = ";
void update(int x, int y) {
if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  
  if (rectOver) {
      realDC = "DC = "+inputValue*255/9;
      myPort.write(inputValue*255/9);
  }
}
int inputValue;
void keyPressed() {
  if (key >= '0' && key <= '9') {
    inputValue = key - '0';
  }
  
  dcOut = ""+inputValue;

}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}