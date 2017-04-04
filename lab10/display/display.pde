import processing.serial.*;
import java.time.*;
import java.util.Date;
import java.nio.file.*;
import java.util.*;
import java.nio.charset.Charset;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
Serial myPort;  // Create object from Serial class
int[] val;      // Data received from the serial port
int counter = 0;
int[] lightVal;
int sizeCounter = 0;
int sizeLight = 0;
void setup() 
{
  size(500, 500);
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  val = new int[10];
  lightVal = new int[10];
  background(255);
}

void draw()
{

  if ( myPort.available() > 0) {  
    counter++;
    lightVal[sizeCounter%10] = myPort.read();
    //println(lightVal[sizeCounter%10]);
    //background(lightVal[sizeCounter%10]);
    //if(counter%2==0){
      sizeCounter++;
      //println(sizeCounter);
      if(sizeCounter >=10){
         Date date = new Date();
         int i,sumLight=0;
          for(i=0;i<10;i++){
            sumLight+= lightVal[i];
          }
   
        text(sumLight/10+" ",225,190); 
        println(""+sumLight/10);
        text("Last updated at"+date,115,230);
      //}
      
      
   /* }else{
      
      val[sizeLight%10] = myPort.read();
      if(sizeLight >= 10){
        Date date = new Date();      
      System.out.println(date); 
      text("Last updated at"+date,115,230);
      int i,sumTemp=0;
      for(i=0;i<10;i++){
        sumTemp+= val[i];
      }
      text((sumTemp/10)+" c",210,150); 
      }*/
      
         
    }
  }else{
    
    Date d = new Date();
    text("Last updated at"+d,115,230);
  }
  
  try{
  List<String> lines = Arrays.asList("","");
  Path file = Paths.get("C:/Users/prasanna/Documents/Studies/Semester 6/Wireless sensor networks/CSD_337_WSN/lab10/display/output.csv");
  Files.write(file,lines,Charset.forName("UTF-8"));
  //println("writing to file");
  }catch(IOException ex){
    println("inside exception");
  }
  //fill(255);
 // rect(100,100,300,300);
 
  
  fill(0);
  text("Temperature = ",115,150);
  text("Light Intensity = ",115,190);
  

  
}