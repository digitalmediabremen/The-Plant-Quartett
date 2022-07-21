#include <ADC.h>
#include <movingAvg.h> 

#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

// GUItool: begin automatically generated code
AudioSynthWaveformSine   modulator;      //xy=1096.6665153503418,521.6666488647461
AudioSynthWaveformSine   sine1;          //xy=1100.0000534057617,428.33330154418945
AudioSynthWaveformSine   sine2;          //xy=1103.3332443237305,601.6667194366455
AudioSynthWaveformSine   sine3;          //xy=1118.3333333333333,658.3333333333333
AudioSynthWaveformSine   sine4;          //xy=1126.6666666666665,768.3333333333333
AudioEffectMultiply      multiply3;      //xy=1366.6665878295898,663.3333473205566
AudioEffectMultiply      multiply4;      //xy=1366.666603088379,731.6666622161865
AudioEffectMultiply      multiply2;      //xy=1373.3334121704102,594.9999618530273
AudioEffectMultiply      multiply1;      //xy=1375.0001602172852,536.666687130928
AudioMixer4              mixer;          //xy=1625.333251953125,595.6666259765625
AudioEffectFreeverb      freeverb1;      //xy=1789.333251953125,600.6666259765625
AudioAmplifier           amp1;           //xy=1918.6665306091309,596.9999389648438
AudioOutputI2S           i2s1;           //xy=2054.999954223633,596.9998912811279
AudioConnection          patchCord1(modulator, 0, multiply1, 1);
AudioConnection          patchCord2(modulator, 0, multiply2, 1);
AudioConnection          patchCord3(modulator, 0, multiply3, 1);
AudioConnection          patchCord4(modulator, 0, multiply4, 1);
AudioConnection          patchCord5(sine1, 0, multiply1, 0);
AudioConnection          patchCord6(sine2, 0, multiply2, 0);
AudioConnection          patchCord7(sine3, 0, multiply3, 0);
AudioConnection          patchCord8(sine4, 0, multiply4, 0);
AudioConnection          patchCord9(multiply3, 0, mixer, 2);
AudioConnection          patchCord10(multiply4, 0, mixer, 3);
AudioConnection          patchCord11(multiply2, 0, mixer, 1);
AudioConnection          patchCord12(multiply1, 0, mixer, 0);
AudioConnection          patchCord13(mixer, freeverb1);
AudioConnection          patchCord14(freeverb1, amp1);
AudioConnection          patchCord15(amp1, 0, i2s1, 0);
AudioConnection          patchCord16(amp1, 0, i2s1, 1);
AudioControlSGTL5000     sgtl5000_1;     //xy=1965.333251953125,1038.6666259765625
// GUItool: end automatically generated code


// on board
const int signalPin = A1; // ADC0
const int audioInPin = A2; // ADC1
const int pot1Pin = A4;
const int pot2Pin = A5;
const int pot3Pin = A6;
const int pot4Pin = A7;

// maping
int pitchPin = pot1Pin;
int modPin = pot2Pin;
int reverbPin = pot4Pin;
int gainPin = pot3Pin;

int LEDPin =  5; // only red works

int sensorData = 0;
int sensorValue = 0;

unsigned long myTime;

float freq = 200;
float freqRange = 100;
float freqBase;
int modRange = 3000;

float mod = 0.2; //0.1-0.25
float goalMod = 0.2;
float goalFreq = 0;
float reverbRoom = 0.7;
float level = 1;

boolean debug = true;

//how many data points are used for the movingavg reading
movingAvg mySensor(10); 

// ADC
ADC *adc = new ADC();
#define USE_ADC_0
#define USE_ADC_1
#define BUFFER_SIZE 1000

String role = "C";

// role A is the bass(till 50), B,C - mid range, D - high
// 
void setup() {
  Serial.begin(9600);
  AudioMemory(15);
  
  // put your setup code here, to run once:
  sgtl5000_1.enable();  // Enable the audio shield
  sgtl5000_1.volume(0.5);  // 0.8 corresponds to the maximum undistorted output for a full scale signal. Usually 0.5 is a comfortable listening level. 

  // Testing...these appear to address a little background noise...
  sgtl5000_1.adcHighPassFilterDisable();
  sgtl5000_1.audioProcessorDisable();

   // Amplitude Modulation
  modulator.frequency(mod);
  modulator.amplitude(1);

  //freeverb
  freeverb1.roomsize(reverbRoom);
  freeverb1.damping(0.4);
  
  // 1-3 amplifies the signal
  // adjust here to tweak the base volume
  // maybe just one channel for the smaller speakers
  mixer.gain(0, 0.5); 
  mixer.gain(1, 0.5);
  mixer.gain(2, 0);
  mixer.gain(3, 0);
  
  //LED and input sound conflicts?
  pinMode(LEDPin, OUTPUT);
  
  adc->adc0->setAveraging(10); // set number of averages
  adc->adc0->setResolution(10); // set bits of resolution
  adc->adc0->setConversionSpeed(ADC_CONVERSION_SPEED::LOW_SPEED); // change the conversion speed
  adc->adc0->setSamplingSpeed(ADC_SAMPLING_SPEED::LOW_SPEED); // change the sampling speed

  mySensor.begin();
  delay(500);

  if (role == "A") {
  freqBase = 50;
} else if(role == "B") {
  freqBase = 100;
} else if(role == "C") {
  freqBase = 200;
} else if(role == "D") {
  freqBase = 800;
}
  freq = freqBase;
  goalFreq = freqBase;

}

void loop() {
  sensorData = analogRead(signalPin);
  sensorValue = mySensor.reading(sensorData);

  analogWrite(LEDPin,  map(sensorValue, 0, 1023, 0,10));
  freqRange = map(analogRead(pitchPin), 0, 1023, 100,10);
  modRange = analogRead(modPin)*3 + 1024*3;
  level = mapfloat(analogRead(gainPin), 0,1023, 2,1); 
  reverbRoom = mapfloat(analogRead(reverbPin), 0,1023,1,0);
  
  delay(10);
  AudioNoInterrupts();
  
  // stronger signal 
  sine1.frequency(freq);
  sine2.frequency(freq);
  sine3.frequency(freq);
  sine4.frequency(freq);
  
  amp1.gain(level);
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
  goalFreq = map(sensorValue, 0, 1023, freqBase-freqRange/2,freqBase + freqRange/2);
  goalMod =  mapfloat(sensorValue, 0,modRange, 0,1);
}

void checkMixer() {
  // chanel 0 -> input
//  if(rms1.available()) {
//    float inputValue = rms1.read();
//    Serial.println(inputValue);
//    if (inputalue < 1) {
//      mixer.gain(0, 0);
//      mixer.gain(1, 1);
//    } else {
//      Serial.println("Input Mix");
//      mixer.gain(0, 1);
//      mixer.gain(1, 0.5);
//    }
//  }
}

void updateSound(){
  // freq = goalFreq;
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

 freeverb1.roomsize(reverbRoom);
  
 if(debug) {
Serial.print("Mod = ");
Serial.println(mod);
// Serial.print("GoalMod = ");
// Serial.println(goalMod);
//Serial.print("ModRange = ");
//Serial.println(modRange);
Serial.print("Freq = ");
Serial.println(freq);
 //Serial.print("FreqBase = ");
 //Serial.println(freqBase);
 //Serial.print("Freqrange = ");
 //Serial.println(freqRange);
 //Serial.print("SensorValue = ");
 //Serial.println(sensorValue);
 }
}

float mapfloat(long x, long in_min, long in_max, long out_min, long out_max)
{
 return (float)(x - in_min) * (out_max - out_min) / (float)(in_max - in_min) + out_min;
}
