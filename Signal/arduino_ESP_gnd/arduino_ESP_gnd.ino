int sensorPin = 35;    // select the input pin for the potentiometer
int sensorPin2 = 34;    
int sensorPin3 = 36;
int gndPin = 39;
int sensorValue = 0;  // variable to store the value coming from the sensor
int sensorValue2 = 0; 
int sensorValue3 = 0; 

void setup() {
   // initialize serial:
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  analogRead(gndPin);
  sensorValue2 = analogRead(sensorPin2);
  analogRead(gndPin);
  sensorValue3 = analogRead(sensorPin3);
  analogRead(gndPin);
 
  Serial.print(sensorValue);
  Serial.print('a');
  Serial.print(sensorValue2);
  Serial.print('b');
  Serial.print(sensorValue3);
  Serial.print("c");

}
