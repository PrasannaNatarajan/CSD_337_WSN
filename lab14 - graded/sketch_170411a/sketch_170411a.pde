import java.util.Date;
import java.text.SimpleDateFormat;
import processing.serial.*;

Serial myPort;        // The serial port


int posX1,posY1,w1,h1,isLDR=0;
String outString = "",sensorName="";   
SimpleDateFormat df=null;
int rectX, rectY;      // Position of square button
int rectSizeX = 110;     // Diameter of rect
int rectSizeY = 50;     // Diameter of rect
color rectColor;
color rectHighlight;
color currentColor;
boolean rectOver = false;
String buttonText="Button";
int accessTime=2;

void setup() {
  size(640, 360);
  noStroke();
  background(255);
  fill(135);
  stroke(255);
  fill(0);
  fill(255);
 
  rectColor = color(255);
  rectHighlight = color(220);
  rectX = 265;
  rectY = 30;
 
    d= new Date();
    df = new SimpleDateFormat("hh:mm:ss dd:mm:yyyy");
  //myPort = new Serial(this, "COM3", 9600);
  //myPort.bufferUntil('\n');
}
void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
   // trim off any whitespace:
    inString = trim(inString);
    d = new Date();
    
      
 }
}
Date d = null;
void draw() {
  // keep draw() here to continue looping while waiting for keys
    update(mouseX, mouseY);
  if(isLDR==1)
    sensorName="LDR";
  else
    sensorName="PIR";
 
 
 
  outString = sensorName + " sensor was last accessed at "+ df.format(d) + " for "+ accessTime +"s";
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  background(255);
  stroke(0);
  rect(rectX, rectY, rectSizeX, rectSizeY);
  fill(255);
  fill(0);
  text(buttonText,rectX+30,rectY+30);
  text(outString, 20,100,600,600);
  stroke(0);
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
    myPort.write('1');
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}