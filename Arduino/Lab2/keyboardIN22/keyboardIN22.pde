int rectX, rectY;      // Position of square button
int rectX2, rectY2;      // Position of square button
int rectX3, rectY3;      // Position of square button
int rectWidth = 90;     // Diameter of rect
color rectColor, baseColor;
color rectHighlight;
color currentColor;
boolean rectOver = false;

void setup() {
  size(640, 360);
  rectColor = color(0);
  rectHighlight = color(51);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = width/3 - rectWidth/2 ;
  rectY = 10;
  rectX2 = width/2 - rectWidth/2 ;
  rectY2 = 10;
  rectX3 = width - rectWidth/2 ;
  rectY3 = 10;
  
  ellipseMode(CENTER);
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
  rect(rectX, rectY, rectWidth, rectWidth*0.4);
  //stroke(0);
  rect(rectX2, rectY2, rectWidth, rectWidth*0.4);
  stroke(0);
}

void update(int x, int y) {
if ( overRect(rectX, rectY, rectWidth, (int)(rectWidth*0.4)) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (rectOver) {
    currentColor = rectColor;
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