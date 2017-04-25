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
//import processing.sound.*;

int numFrames = 40;  // The number of frames for GIF1 in the animation
int numFramesLine = 25;  // The number of frames for GIF2 in the animation
int numFramesAwake = 20; // The number of frames for GIF3 in the animation
int currentFrame = 0;
int currentFrameLine=0;
int currentFrameAwake=0;
PImage[] images = new PImage[numFrames];  // Creating GIF1
PImage[] lineI = new PImage[numFramesLine];  // Creating GIF2
PImage[] awake = new PImage[numFramesAwake]; // Creating GIF3
PFont font;
//WhiteNoise wn;
SoundFile sf;
BufferedWriter bw = null;
FileWriter fw = null;
/* First button */
int rectXBase=-1280;
int rectX=870, rectY=400-40;            // Position of "Wake UP" button
int rectSizeX = 160,rectSizeY = 80;     // Dimensions of "Wake UP" button
color rectColor;                        // Color of button
color rectHighlight;                    // Hover color
boolean rectOver = false;
/* First button */    

/* Second button */
int rectX2=560, rectY2=350;            // Position of "Sleep" button
int rectSizeX2 = 160,rectSizeY2 = 80;  // Dimensions
color rectColor2;                      // Color of button
color rectHighlight2;                  // Hover color
boolean rectOver2 = false;
/* Second button */    

/* Third button */
int rectX3=560, rectY3=175;            // Position of "Show Statistics" button
int rectSizeX3 = 160,rectSizeY3 = 80;  // Dimensions of "Show Statistics" button
color rectColor3;                      // Color of button
color rectHighlight3;                  // Hover Color
boolean rectOver3 = false;
/* Third button */    

boolean initV=true;




Serial myPort;  // Create object from Serial class

String input;  //to store received value from arduino
int sound;     //to store sound value from input
int light;     //to store light value from input
int volUp;     //to store volume up value from input
int volDown;   //to store volume down value from input

File file;

void setup(){
  
  size(1280, 800);                      // set the window size to be 1280*800
  //wn = new WhiteNoise(this);
  sf= new SoundFile(this,"song.mp3");    // Reference to audio file to be played containing White Noise
  frameRate(60);                         // Frame rate = 60
  surface.setTitle("Catnap");            // Page Title
  file = new File("C:\\Users\\prasanna\\Documents\\Studies\\Semester 6\\Wireless sensor networks\\CSD_337_WSN\\project\\UI_merged\\sketch_170416a\\data\\hari.csv");  //Statistics storage file path
    // if file doesnt exists, then create it
    if(file.exists()){
         file.delete();       
    }
    //if (!file.exists()) {
      try {
        file.createNewFile();
        fw = new FileWriter(file.getAbsoluteFile(), true);
        bw = new BufferedWriter(fw);
        PrintWriter pw = new PrintWriter(bw);
        
        pw.println("Time,Sound,Light");   // Heading for .csv file to store data
        pw.flush();
        System.out.println("Done heading");
        pw.close(); 
      } catch (IOException e) {
        e.printStackTrace();
      }
  font = createFont("Rochester-Regular.ttf", 32);  //import font
  textFont(font);                                  //set font to text
  
  rectColor = color(255);
  rectHighlight = color(240);
  rectColor2 = color(255);
  rectHighlight2 = color(240);
  rectColor3 = color(255);
  rectHighlight3 = color(240);
  
  // Preparing GIF files
  
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
  
  // End of preparing GIF files
  
  myPort = new Serial(this, "COM6", 9600);        // Initialise COM port to connect to Arduino 
  myPort.bufferUntil('\n');                       //buffer the input received from serial connection till \n      
}


int offset=0;
int isMove=0;
int offsetShapeX=0;


void draw(){
  background(255);
  {                                                // UI elements of frame1
    update(mouseX, mouseY);                        // Update variables based on mouse current position
    if (rectOver2) {
    fill(rectHighlight2);
    } else {
      fill(rectColor2);
    }
    stroke(0);
    strokeWeight(2);
    rect(rectX2, rectY2, rectSizeX2, rectSizeY2,20);// Draw "Sleep Now" button
    fill(0);
    text("Sleep now!", rectX2+ 30, rectY2+50);
    
    if (rectOver3) {
      fill(rectHighlight3);
    } else {
      fill(rectColor3);
    }
    stroke(0);
    strokeWeight(2);
    rect(rectX3, rectY3, rectSizeX3, rectSizeY3,20);// Draw "See Statistics" button
    fill(0);
    text("See Statistics", rectX3+ 10, rectY3+50);
    
    currentFrameAwake = (currentFrameAwake+1) % numFramesAwake;  // Used to cycle through frames for GIF
    image(awake[(currentFrameAwake) % numFramesAwake], 470, 530);
  }
  {                                                              // UI elements of frame1
    fill(0);
    rect(rectXBase,0,1280,800);
    fill(110,225,230);
    stroke(110,225,230);
    currentFrame = (currentFrame+1+(currentFrame%2)) % numFrames; // Used to cycle through frames for GIF
    if(isMove==1)                                                 // Set ground line to shake when sound detected
      currentFrameLine = (currentFrameLine+1+(currentFrameLine%2)) % numFramesLine;  // Used to cycle through frames for GIF
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
    rect(rectX+rectXBase, rectY, rectSizeX, rectSizeY,20);    // Draw "Wake up" button
    fill(0);
    text("Wake up!", rectX+ 26+rectXBase, rectY+50);
    rectXBase-=mult;                                          // Slide from frame1 to frame2 on button click
    if((rectXBase>=0)||(rectXBase<=-1280))
      mult=0;
  }
}

int mult=0;
void update(int x, int y) {
  if ( overRect(rectX+rectXBase, rectY, rectSizeX, rectSizeY) ) {  // Hover over "Wake up!" button
    rectOver = true;
    rectOver2 = false;
    rectOver3=false;
  } else if (overRect2(rectX2, rectY2, rectSizeX2, rectSizeY2) ){  // Hover over "Sleep!" button
    rectOver = false;
    rectOver2 = true;
    rectOver3=false;
  }
  else if(overRect3(rectX3, rectY3, rectSizeX3, rectSizeY3)){      // Hover over "See Statistics" button
    rectOver = false;
    rectOver2 = false;
    rectOver3= true;
  }
  else{                                                            // Hover outside all button areas
    rectOver = false;
    rectOver2 = false;
    rectOver3 = false;
  }
}
int buttonActivate = 0;        //for checking if the machine is ON or OFF
void mousePressed() {
  //System.out.println("Clicked");
  if (rectOver&&(rectXBase > -1280)&&buttonActivate==1) {                             // Clicked on "Wake Up!" button
    mult=10;
    //wn.stop(); 
    sf.stop(); 
  }
  else if (rectOver2&&buttonActivate==1){                                             // Clicked on "Sleep!" button
    mult=-10;
   // wn.play();
   sf.loop();
    println("**********************************************Time*****************************************************");
    //wn.amp(0.9);
    sf.amp(0.9);
  }
  else if(rectOver3&&buttonActivate==1){                                              // Clicked on "See Statistics!" button
    System.out.println("Clicked Inside");
    clickStat();
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
int sum=0, ii, medianVal=590;
float soundCounter = 0.8;
void serialEvent(Serial p){
 try
 {
  input = p.readStringUntil('\n');
        
  if(input !=null){
    // println(input);
    // println("here");
  }
  
  if(input.indexOf("S") !=-1){
    buttonActivate = 1;
    // println("converting S");
     input = input.replace("\n","");
     input = input.replace(" ","");
     //println(input.substring(1));
     sound = Integer.parseInt(input.substring(1,input.length()-1)); // Parse received Sound value
     //int i= 0;
     //while(i<100){
     if(sound!=0){
       sum+=sound;
       ii=(ii+1)%15;
       if(ii==0){
         medianVal = sum/15;                            // Calculate a current mean value from given data
         
         sum=0;
       }
       println(medianVal + "," + sound);
     }
     //}
     if(Math.abs(sound-medianVal)>3 && sound!=0){      // Disturbance detected, disturbance threshold = 3
       isMove=1;
        //println("inside wiggle");
       if(sound>medianVal)
       {
         //println("inside sound>medianVal");
         soundCounter+=0.1;                            // Increase volume
         if(soundCounter>1)                            // Check bounds
         {
           soundCounter-=0.1;        
           
           //println("sc +"+soundCounter);
         }
         //wn.amp(soundCounter);
         sf.amp(soundCounter);                         // Set output volume
       }
       else
       {
         //println("inside else");
         soundCounter-=0.1;                            // Decrease volume
         if(soundCounter<0.4)                          // Check bounds
         {
           //println("sc -"+soundCounter);
           soundCounter+=0.1;
           
         }
         //wn.amp(soundCounter);
         sf.amp(soundCounter);                         // Set output volume
       }
       
     }
     else{
       //println("inside no wiggle");
       isMove=0;
     }
  }
  
  if(input.indexOf("L")!=-1){
    buttonActivate = 1;
    //println("converting L");
     input = input.replace("\n","");
     light = Integer.parseInt(input.substring(1,input.length()-1));    // Parse received Light value
  }
  
  //if(input.indexOf("VP")!=-1){
  //  println("converting VP");
  //  input = input.replace("\n","");
  //  volUp = Integer.parseInt(input.substring(2,input.length()-1));
  //  isMove = 1;
  //}
  //else if(input.indexOf("VD")!=-1){
  //  input = input.replace("\n","");
  //  println("converting VD");
  //  volDown = Integer.parseInt(input.substring(2,input.length()-1));
  //  isMove = 1;
  //}
  //else{
  //   isMove = 0; 
  //}
   
  //call functions for controlling audio output and volume control
  
  if(sound!=0){
    writeIntoFile(sound,light);      // Record values if valid
    delay(1000);
  }
  
 }catch(Exception e){
   e.printStackTrace(); 
  }
 

}

void writeIntoFile(int sound, int light){  // Record values in a format readable as a comma delimited .csv
   
    //writing into a csv file
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
      e.printStackTrace();
    }
    
  
}
void clickStat(){    // Triggered on click of "See Statistics" button to run utility to display statistics trends
 println("inside here");
  /*try {
      Process p = Runtime.getRuntime().exec("D:\\showStat.cpython-36.pyc");
    } catch (IOException e1) {
      // TODO Auto-generated catch block
      println("inside catch");
      e1.printStackTrace();
    }*/
    launch("D:\\showStat.cpython-36.pyc");          // Run graph generation for recorded statistics
}