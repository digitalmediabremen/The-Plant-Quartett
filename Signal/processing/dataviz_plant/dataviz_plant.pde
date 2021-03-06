import supercollider.*;
import oscP5.*;

Synth synth;

import processing.serial.*;
Serial myPort;  
float gsrValue;
float prevValue = 0;
int t = 0;
int[] allData = {};
boolean record = false;
int maxDataL = 40 * 5; // 5min
String fileName = "";
int counter = 0;
String[] variables = {};

void setup () {
  background(0);
  size(900, 450);
  stroke(255, 50, 50);
  println(Serial.list()[3]);
  myPort = new Serial(this, Serial.list()[3], 9600);
  //initSuperCollider();
}

void initSuperCollider() {
  // uses default sc server at 127.0.0.1:57110    
  // does NOT create synth!
  synth = new Synth("sine");
  
  // set initial arguments
  synth.set("amp", 0.5);
  synth.set("freq", 80);
  
  // create synth
  synth.create();
  
}

void draw () {
  line(t, prevValue, t+1, gsrValue);
  prevValue = gsrValue;
  
  //synth.set("freq", 40 + gsrValue); 

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
  s = variables[0];
  gsrValue = map(float(s), 0, 1024*4, height/2, 50);
  t += 2;
  counter ++;
  if (record) {
    if (allData.length >= maxDataL) {
      saveFile();
    } else {
      if (counter % 5 == 0) allData = append(allData, int(s));
    }
  } else {
    if (minute() % 10 == 0 ) startRecording();
  }
  
}
 
String[] intToString(int[] arr){
  String[] result = {};
  for (int i = 0; i < arr.length; i++) {
    result = append(result, str(arr[i]));
  }
  return result;
} 

String getFileName() {
  fileName = fileName + "-" + day() + "_" + hour() + "_" + minute() + "_" + second();
  return fileName;
}

void saveFile() {
  String n = getFileName();
  println ("save recording to", n);
  saveStrings(n + ".txt", intToString (allData));
  fileName = ""; 
  allData = new int[0];
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
