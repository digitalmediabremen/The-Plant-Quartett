import supercollider.*;
import oscP5.*;

Synth synth;

import processing.serial.*;
Serial myPort;  
float gsrValue;
float prevValue = 0;
int t = 0;

void setup () {
  background(0);
  size(900, 450);
  stroke(255, 50, 50);
  print(this, Serial.list()[3]);
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
  s = myPort.readStringUntil('\n');
  if (s == null) return;
  gsrValue = map(float(s), 0, 1024, 0, height/2);
  println("gsrValue " + gsrValue);
  line(t, prevValue, t, gsrValue);
  t += 2;
}

void exit()
{
    synth.free();
    super.exit();
}
