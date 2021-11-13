#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

// GUItool: begin automatically generated code
AudioSynthWaveformSineModulated sine_fm1;       //xy=105,241
AudioSynthWaveformSine   modulator;      //xy=107,291
AudioEffectMultiply      multiply1;      //xy=257,258
AudioInputI2S            i2s2;           //xy=282,154
AudioEffectFreeverb      freeverb1;      //xy=413,263
AudioMixer4              mixer;          //xy=712,269
AudioOutputI2S           i2s1;           //xy=838,272
AudioConnection          patchCord1(sine_fm1, 0, multiply1, 0);
AudioConnection          patchCord2(modulator, 0, multiply1, 1);
AudioConnection          patchCord3(multiply1, freeverb1);
AudioConnection          patchCord4(i2s2, 0, mixer, 0);
AudioConnection          patchCord5(i2s2, 1, mixer, 1);
AudioConnection          patchCord6(freeverb1, 0, mixer, 2);
AudioConnection          patchCord7(mixer, 0, i2s1, 1);
AudioControlSGTL5000     sgtl5000_1;     //xy=126,111
// GUItool: end automatically generated code


//test granular
//test bitcrush

const int myInput = AUDIO_INPUT_LINEIN;

int signalPin = 0;
int pitchPin = 1;
int modPin = 2;
int LEDPin =  13;

int sensorValue = 0;
unsigned long myTime;

float freq = 200;
float freqRange = 300;
int modRange = 1;

float mod = 0.2; //0.1-0.25
float goalMod = 1;
float goalFreq = 0;

boolean debug = false;

void setup() {
  AudioMemory(12);
  
  // put your setup code here, to run once:
  sgtl5000_1.enable();  // Enable the audio shield
  sgtl5000_1.inputSelect(myInput);
  sgtl5000_1.volume(1);
  sgtl5000_1.lineInLevel(10);//0-15

  // Testing...these appear to address a little background noise...
  sgtl5000_1.adcHighPassFilterDisable();
  sgtl5000_1.audioProcessorDisable();

  // Amplitude Modulation
  modulator.frequency(0.2);
  modulator.amplitude(mod);

  //biquad1.setLowpass(0, 800, 0.707);

  //freeverb
  freeverb1.roomsize(0.7);
  freeverb1.damping(0.4);

  //default mixer
  mixer.gain(0, 0.5);
  mixer.gain(1, 0.5);
  //
  mixer.gain(2, 0.5);

  //LED for on
   pinMode(LEDPin, OUTPUT);
   digitalWrite(LEDPin, HIGH);

  //Serial.begin(9600);
}

void loop() {
  sensorValue = analogRead(signalPin);
  freqRange = map(analogRead(pitchPin), 0, 1023, 100,800);
  modRange = analogRead(modPin)*3 + 1024*2;
  
  delay(10);
  AudioNoInterrupts(); 
  sine_fm1.frequency(freq);
  modulator.frequency(mod);
  updateSound();
  AudioInterrupts(); 
  
  myTime = millis();
  
  //every 5 seconds
  if(int(myTime/1000)%5 == 0) {
    interpretValue();
   // checkMixer();
  }
   
  delay(50);
  // put your main code here, to run repeatedly:
}


void interpretValue() {
  goalFreq = map(sensorValue, 0, 1023, 30,freqRange);
  goalMod =  mapfloat(sensorValue, 0,modRange, 0,1);
  
}

void updateSound(){
  if (freq < goalFreq){
    freq += 1;
  } else if(freq > goalFreq){
    freq -= 1;
  }

  if (mod < goalMod-0.01){
    mod += 0.01;
  } else if(mod > goalMod && mod > 0.1) {
    mod -= 0.01;
  }
  
 if(debug) {
 Serial.print("Mod = ");
 Serial.println(mod);
 Serial.print("GoalMod = ");
 Serial.println(goalMod);
 Serial.print("ModRange = ");
 Serial.println(modRange);
 Serial.print("Freq = ");
 Serial.println(freq);
 Serial.print("GoalFreq = ");
 Serial.println(goalFreq);
 Serial.print("Freqrange = ");
 Serial.println(freqRange);
 Serial.print("SensorValue = ");
 Serial.println(sensorValue);
 Serial.print("InputValue = ");
 Serial.println(myInput);
 }
}

float mapfloat(long x, long in_min, long in_max, long out_min, long out_max)
{
 return (float)(x - in_min) * (out_max - out_min) / (float)(in_max - in_min) + out_min;
}
