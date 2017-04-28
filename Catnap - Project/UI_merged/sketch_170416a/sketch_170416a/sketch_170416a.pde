/*
 This is our submission of the source code of the project for Wireless Sensor Networks (CSD337), which consists of implementation of Slumbear, a sleep assistant.
 The code has been written in Arduino IDE and Processing.

 AUTHORS
 Atish Majumdar      : 1410110081
 Prasanna Natarajan  : 1410110298
 Vedant Chakravarthy : 1410110489
*/

import processing.serial.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

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




Serial myPort;  // Create object from Serial class

String input;
int sound;
int light;
int volUp;
int volDown;


void setup(){
  
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
  myPort = new Serial(this, "COM6", 9600); 
  myPort.bufferUntil('\n');
}


int offset=0;
int isMove=0;
int offsetShapeX=0;


void draw(){
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
    clickStat();
    
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
void serialEvent(Serial p){
 
  input = p.readStringUntil('\n');
        
  if(input !=null){
     println(input);
     println("here");
  }
  
  if(input.indexOf("S") !=-1){
     println("converting S");
     input = input.replace("\n","");
     input = input.replace(" ","");
     println(input.substring(1));
     sound = Integer.parseInt(input.substring(1,input.length()-1));         
  }
  
  if(input.indexOf("L")!=-1){
    println("converting L");
     input = input.replace("\n","");
     light = Integer.parseInt(input.substring(1,input.length()-1));
  }
  
  if(input.indexOf("VP")!=-1){
    println("converting VP");
    input = input.replace("\n","");
    volUp = Integer.parseInt(input.substring(2,input.length()-1));
  }
  if(input.indexOf("VD")!=-1){
    input = input.replace("\n","");
    println("converting VD");
    volDown = Integer.parseInt(input.substring(2,input.length()-1));
  }
   
  //call functions for controlling audio output and volume control
  
  
  writeIntoFile(sound,light);      
  delay(1000);

}

void writeIntoFile(int sound, int light){
   BufferedWriter bw = null;
    FileWriter fw = null;
    File file = new File("C:\\Users\\prasanna\\Documents\\Studies\\Semester 6\\Wireless sensor networks\\CSD_337_WSN\\project\\sketch_170416a\\data.csv");
    // if file doesnt exists, then create it
    if (!file.exists()) {
      try {
        file.createNewFile();
      } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }
    try {
      fw = new FileWriter(file.getAbsoluteFile(), true);
      bw = new BufferedWriter(fw);
      PrintWriter pw = new PrintWriter(bw);
      Date dNow = new Date( );
      SimpleDateFormat ft = new SimpleDateFormat ("hh:mm:ss");
      pw.println(ft.format(dNow)+","+sound+","+light);
      pw.flush();
      System.out.println("Done");
      pw.close();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
  
}
void clickStat(){
 println("inside here");
  try {
      Process p = Runtime.getRuntime().exec("notepad.exe");
    } catch (IOException e1) {
      // TODO Auto-generated catch block
      println("inside catch");
      e1.printStackTrace();
    }
}