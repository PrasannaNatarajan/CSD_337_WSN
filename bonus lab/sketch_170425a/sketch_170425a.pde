import processing.serial.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

Serial myPort;  // Create object from Serial class

String input;  //to store received value from arduino
int temp;     //to store sound value from input

void setup(){
  
  size(1280, 800);                      // set the window size to be 1280*800
    
  myPort = new Serial(this, "COM5", 9600);        // Initialise COM port to connect to Arduino 
  myPort.bufferUntil('\n');                       //buffer the input received from serial connection till \n      

}

void draw(){
  
}
void serialEvent(Serial p){
 
  input = p.readStringUntil('\n');
        
  if(input !=null){
     println(input);
     println("here");
  }
  input = input.replace("\n","");
  input = input.replace(" ","");
  temp = Integer.parseInt(input);
   
  //call functions for controlling audio output and volume control
  
  
  writeIntoFile(temp);      
  delay(1000);

}

void writeIntoFile(int temp){
   BufferedWriter bw = null;
    FileWriter fw = null;
    File file = new File("C:\\Users\\prasanna\\Documents\\Studies\\Semester 6\\Wireless sensor networks\\CSD_337_WSN\\bonus lab\\temp.csv");
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
      pw.println(ft.format(dNow)+","+temp);
      pw.flush();
      System.out.println("Done");
      pw.close();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
  
}