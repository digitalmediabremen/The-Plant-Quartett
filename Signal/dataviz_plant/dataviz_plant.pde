import supercollider.*;
import oscP5.*;

Synth synth;

import processing.serial.*;
Serial myPort;  
float gsrValue;
float prevValue = 0;
int t = 0;
float[] allData = {};
boolean record = false;
int maxDataL = 120 * 5; // 5min
String fileName = "";

void setup () {
  background(0);
  size(900, 450);
  stroke(255, 50, 50);
  println(Serial.list()[3]);
  myPort = new Serial(this, Serial.list()[3], 9600);
  initSuperCollider();
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
  s = myPort.readStringUntil('a');
  if (s == null) return;
  gsrValue = map(float(s), 0, 1024, height/2, 50);
  println("gsrValue " + gsrValue);
  line(t, prevValue, t, gsrValue);
  t += 2;
  if (record) {
    if (allData.length >= maxDataL) {
      saveFile();
    } else {
      allData = append(allData, gsrValue);
    }
  } else {
    if (minute() % 37 == 0 ) startRecording();
  }
  
}
 
String[] floatToString(float[] arr){
  String[] result = {};
  for (int i = 0; i < arr.length; i++) {
    result = append(result, str(arr[i]));
  }
  return result;
}

String getFileName() {
  fileName = fileName + "-" + day() + "_" + hour() + "_" + minute();
  return fileName;
}

void saveFile() {
  String n = getFileName();
  println ("save recording to", n);
  saveStrings(n + ".txt", floatToString (allData));
  fileName = ""; 
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
