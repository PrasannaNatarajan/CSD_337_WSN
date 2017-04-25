int numFrames = 40;  // The number of frames in the animation
int numFramesLine = 25;
int numFramesAwake = 20;
int currentFrame = 0;
int currentFrameLine=0;
int currentFrameAwake=0;
PImage[] images = new PImage[numFrames];
PImage[] lineI = new PImage[numFramesLine];
PImage[] awake = new PImage[numFramesAwake];
PFont font;

/* First button */
int rectXBase=-1280;
int rectX=870, rectY=400-40;      // Position of square button
int rectSizeX = 160,rectSizeY = 80;     // Diameter of rect
color rectColor;
color rectHighlight;
boolean rectOver = false;
/* First button */    

/* Second button */
int rectX2=560, rectY2=350;      // Position of square button
int rectSizeX2 = 160,rectSizeY2 = 80;     // Diameter of rect
color rectColor2;
color rectHighlight2;
boolean rectOver2 = false;
/* Second button */    

/* Third button */
int rectX3=560, rectY3=175;      // Position of square button
int rectSizeX3 = 160,rectSizeY3 = 80;     // Diameter of rect
color rectColor3;
color rectHighlight3;
boolean rectOver3 = false;
/* Third button */    

boolean initV=true;

void setup() {
  size(1280, 800);
  frameRate(60);
  
  font = createFont("Rochester-Regular.ttf", 32);
  textFont(font);
  
  rectColor = color(255);
  rectHighlight = color(240);
  rectColor2 = color(255);
  rectHighlight2 = color(240);
  rectColor3 = color(255);
  rectHighlight3 = color(240);
  
  images[0]  = loadImage("output/1.gif");
  for(int x=1;x<=9;x++)
    images[x]  = images[x-1];
  
  images[10]  = loadImage("output/2.gif");
  for(int x=11;x<=19;x++)
    images[x]  = images[x-1];
  
  images[20]  = loadImage("output/3.gif");
  for(int x=21;x<=29;x++)
    images[x]  = images[x-1];
  
  images[30]  = loadImage("output/4.gif");
  for(int x=31;x<=39;x++)
    images[x]  = images[x-1];
  
  for(int x=0;x<=24;x++)
    lineI[x]  = loadImage("line/"+(x+1)+".gif");
    
  awake[0]  = loadImage("awake/1.gif");
  for(int x=1;x<=9;x++)
    awake[x]  = awake[x-1];
  
  awake[10]  = loadImage("awake/2.gif");
  for(int x=11;x<=19;x++)
    awake[x]  = awake[x-1];
} 

int offset=0;
int isMove=0;
int offsetShapeX=0;
void draw() { 
  background(255);
  {
    update(mouseX, mouseY);
    if (rectOver2) {
    fill(rectHighlight2);
    } else {
      fill(rectColor2);
    }
    stroke(0);
    strokeWeight(2);
    rect(rectX2, rectY2, rectSizeX2, rectSizeY2,20);
    fill(0);
    text("Sleep now!", rectX2+ 30, rectY2+50);
    
    if (rectOver3) {
      fill(rectHighlight3);
    } else {
      fill(rectColor3);
    }
    stroke(0);
    strokeWeight(2);
    rect(rectX3, rectY3, rectSizeX3, rectSizeY3,20);
    fill(0);
    text("See Statistics", rectX3+ 10, rectY3+50);
    
    currentFrameAwake = (currentFrameAwake+1) % numFramesAwake;  // Use % to cycle through frames
    image(awake[(currentFrameAwake) % numFramesAwake], 470, 530);
  }
  {
    fill(0);
    rect(rectXBase,0,1280,800);
    fill(110,225,230);
    stroke(110,225,230);
    currentFrame = (currentFrame+1+(currentFrame%2)) % numFrames;  // Use % to cycle through frames
    if(isMove==1)
      currentFrameLine = (currentFrameLine+1+(currentFrameLine%2)) % numFramesLine;  // Use % to cycle through frames
    else
      currentFrameLine=0;
    ellipse(340+rectXBase,400,560,400);
    image(lineI[(currentFrameLine) % numFramesLine], 90+rectXBase, 350);  
    image(images[(currentFrame) % numFrames], 100+rectXBase, 200);
    fill(120);
    stroke(120);
     //update(mouseX, mouseY);
    //background(currentColor);
    
    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(0);
    strokeWeight(2);
    rect(rectX+rectXBase, rectY, rectSizeX, rectSizeY,20);
    fill(0);
    text("Wake up!", rectX+ 26+rectXBase, rectY+50);
    rectXBase-=mult;
    if((rectXBase>=0)||(rectXBase<=-1280))
      mult=0;
  }
}
int mult=0;
void update(int x, int y) {
  if ( overRect(rectX+rectXBase, rectY, rectSizeX, rectSizeY) ) {
    rectOver = true;
    rectOver2 = false;
    rectOver3=false;
  } else if (overRect2(rectX2, rectY2, rectSizeX2, rectSizeY2) ){
    rectOver = false;
    rectOver2 = true;
    rectOver3=false;
  }
  else if(overRect3(rectX3, rectY3, rectSizeX3, rectSizeY3)){
    rectOver = false;
    rectOver2 = false;
    rectOver3= true;
  }
  else{
    rectOver = false;
    rectOver2 = false;
    rectOver3 = false;
  }
}

void mousePressed() {
  //System.out.println("Clicked");
  if (rectOver&&(rectXBase > -1280)) {
    mult=10;
  }
  else if (rectOver2){
    mult=-10;
  }
  else if(rectOver3)
    System.out.println("Clicked Inside");
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRect2(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRect3(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}