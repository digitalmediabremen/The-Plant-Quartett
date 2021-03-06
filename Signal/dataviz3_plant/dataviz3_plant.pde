import oscP5.*;
import processing.serial.*;
Serial myPort;  

int t = 0;

String[] variables = {};
float[] prevValues = {};
String[] allData = {};

// save file
boolean record = false;
String fileName = "";
int counter = 0;
int maxDataL = 40 * 5; // 5min

void setup () {
  background(0);
  size(900, 450);
  println(Serial.list()[3]);
  myPort = new Serial(this, Serial.list()[3], 9600);
}

void draw () {

  display(variables);
  
  if (t >= width) {
    background(0);
    t = 0;
  }
}

void serialEvent (Serial myPort) {
  String s;
  // println("serial event!");
  s = myPort.readStringUntil(99); // 97 - a
  
  if (s == null) return;
  s = s.replace("a", " ");
  s = s.replace("b", " ");
  s = s.replace("c", " ");
  println("gsrValue " + s);
  variables = s.split(" ");
  
  t += 2;
  counter ++;
  
  if (record) {
    if (allData.length >= maxDataL) {
      saveFile();
    } else {
      if (counter % 5 == 0) allData = append(allData, s);
    }
  } else {
    if (minute() % 10 == 0 ) startRecording();
  }
  
}
 
String getFileName() {
  fileName = fileName + "-" + day() + "_" + hour() + "_" + minute() + "_" + second();
  return fileName;
}

void display(String[] v) {
  
  if(prevValues.length == 0) prevValues = new float[v.length];
   
  for (int i = 0; i < v.length; i ++) {
    stroke(i==0?200:50, i==1?200:50, i==2?200:50);
    float gsrValue = map(int(variables[i]), 0, 1024*4, height-50, 50);
    //print(prevValues[i], gsrValue);
    //line(t, prevValues[i], t, gsrValue);
    prevValues[i] = gsrValue;
  }
  
}

void saveFile() {
  String n = getFileName();
  println ("save recording to", n);
  saveStrings(n + ".txt", allData);
  fileName = ""; 
  allData = new String[0];
  counter = 0;
  record = false;
}

void startRecording() {
  record = true;
  fileName = getFileName();
  println ("start recording", fileName);
}

void keyPressed() { // Press a key to save the data
  if(record) {
    saveFile();
  } else {
    startRecording();
  }
}
