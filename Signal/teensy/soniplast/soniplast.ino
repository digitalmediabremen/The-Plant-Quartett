#include <ADC.h>
#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>
#include <movingAvg.h>  

// GUItool: begin automatically generated code
AudioSynthWaveformSine   modulator;      //xy=1130,501
AudioSynthWaveformSineModulated sine_fm1;       //xy=1131,456
AudioEffectMultiply      multiply1;      //xy=1280,468
AudioEffectFreeverb      freeverb1;      //xy=1419,468
AudioAmplifier           amp1;           //xy=1557,468
AudioOutputI2S           i2s1;           //xy=1705,474
AudioConnection          patchCord1(modulator, 0, multiply1, 1);
AudioConnection          patchCord2(sine_fm1, 0, multiply1, 0);
AudioConnection          patchCord3(multiply1, freeverb1);
AudioConnection          patchCord4(freeverb1, amp1);
AudioConnection          patchCord5(amp1, 0, i2s1, 0);
AudioConnection          patchCord6(amp1, 0, i2s1, 1);

// GUItool: end automatically generated code

// on board
const int signalPin = A1; // ADC0
const int audioInPin = A2; // ADC1
const int pot1Pin = A4;
const int pot2Pin = A5;
const int pot3Pin = A6;
const int pot4Pin = A7;

// maping
const int myInput = audioInPin;
int pitchPin = pot1Pin;
int modPin = pot2Pin;
int reverbPin = pot4Pin;
int gainPin = pot3Pin;

int LEDPin =  5; // only red works

int sensorData = 0;
int sensorValue = 0;

unsigned long myTime;

float freq = 200;
float freqRange = 300;
int modRange = 1;

float mod = 0.2;
float goalMod = 1;
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
#define BUFFER_SIZE 500

void setup() {
  Serial.begin(9600);
  AudioMemory(12);

  // Amplitude Modulation
  modulator.frequency(0.2);
  modulator.amplitude(mod);

  //freeverb
  freeverb1.roomsize(reverbRoom);
  freeverb1.damping(0.4);

  // power
  //pinMode(LED_BUILTIN, OUTPUT);
  //digitalWrite(LEDPin, HIGH);
  pinMode(LEDPin, OUTPUT);
  adc->adc0->setAveraging(10); // set number of averages
  adc->adc0->setResolution(10); // set bits of resolution
  adc->adc0->setConversionSpeed(ADC_CONVERSION_SPEED::LOW_SPEED); // change the conversion speed
  adc->adc0->setSamplingSpeed(ADC_SAMPLING_SPEED::LOW_SPEED); // change the sampling speed

  mySensor.begin();
  delay(2000);
}

void loop() {
  sensorData = analogRead(signalPin);
  sensorValue = mySensor.reading(sensorData);
  
  analogWrite(LEDPin,  map(sensorValue, 0, 1023, 0,10));
  
  freqRange = map(analogRead(pitchPin), 0, 1023, 800,0);
  modRange = analogRead(modPin)*5 + 1024*2; // mod 0.14-0.5
  level = mapfloat(analogRead(gainPin), 0,1023, 2,1); 
  reverbRoom = mapfloat(analogRead(reverbPin), 0,1023,1,0);
  
  delay(50);
  AudioNoInterrupts(); 
  sine_fm1.frequency(freq);
  amp1.gain(level);
  modulator.frequency(mod);
  updateSound();
  AudioInterrupts(); 
  
  myTime = millis();
  
  //every 5 seconds
  if(int(myTime/1000) % 5 == 0) {
    interpretValue();
  }
  
  delay(50);
}


void interpretValue() {
  goalFreq = map(sensorValue, 0, 1023, 30,freqRange);
  goalMod =  mapfloat(sensorValue, 0,modRange, 0,1);
}

void updateSound(){
//  if (freq < goalFreq){
//    freq += 1;
//  } else if(freq > goalFreq){
//    freq -= 1;
//  }

  if (mod < goalMod-0.01){
    mod += 0.01;
  } else if(mod > goalMod && mod > 0.1) {
    mod -= 0.01;
  }

 freeverb1.roomsize(reverbRoom);
  
 if(debug) {
// Serial.print("Mod = ");
// Serial.println(mod);
// Serial.print("GoalMod = ");
// Serial.println(goalMod);

// Serial.print("Freq = ");
// Serial.println(freq);
// Serial.print("GoalFreq = ");
// Serial.println(goalFreq);

 Serial.print("SensorValue = ");
 Serial.println(sensorValue);
// Serial.print("ModRange = ");
// Serial.println(modRange);
// Serial.print("Freqrange = ");
// Serial.println(freqRange);
// Serial.print("gainValue = ");
// Serial.print(level);
// Serial.print("\t reverbValue = ");
// Serial.println(reverbRoom);
 }
}

float mapfloat(long x, long in_min, long in_max, long out_min, long out_max)
{
 return (float)(x - in_min) * (out_max - out_min) / (float)(in_max - in_min) + out_min;
}
