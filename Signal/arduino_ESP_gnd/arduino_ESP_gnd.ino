int sensorPin = 2; //ADC2 
int sensorPin2 = 35; 

int sensorPin3 = 4; //ADC2 
int sensorPin4 = 34; 
int currentPin = 36; 
int gndPin = 39; 

int sensorValue = 0;  // variable to store the value coming from the sensor
int sensorValue2 = 0; 
int sensorValue3 = 0; 
int sensorValue4 = 0; 
int gndValue = 0;
int currentValue = 0;
void setup() {
   // initialize serial:
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin); //adc2
  analogRead(gndPin); //1
  delay(5);
  sensorValue2 = analogRead(sensorPin2);//adc1
  delay(5);
  sensorValue3 = analogRead(sensorPin3);//adc2
  analogRead(gndPin);//1
  sensorValue4 = analogRead(sensorPin4);//adc1
  gndValue = analogRead(gndPin);
  delay(5);
  currentValue = analogRead(currentPin);//1
  
  Serial.print(sensorValue);
  Serial.print('a');
  Serial.print(sensorValue2);
  Serial.print('b');
  Serial.print(sensorValue3);
  Serial.print("c");
  Serial.print(sensorValue4);
  Serial.print("d");
  Serial.print(currentValue);
  Serial.print("e");
  delay(1000);
}
