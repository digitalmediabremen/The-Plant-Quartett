int sensorPin = A1;    // select the input pin for the potentiometer
int sensorPin2 = A2;    
int sensorPin3 = A3;
int sensorPin4 = A4;
int sensorValue = 0;  // variable to store the value coming from the sensor
int sensorValue2 = 0; 
int sensorValue3 = 0; 
int sensorValue4 = 0; 

void setup() {
   // initialize serial:
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  sensorValue2 = analogRead(sensorPin2);
  sensorValue3 = analogRead(sensorPin3);
  sensorValue4 = analogRead(sensorPin4);
  delay(500);
  // processing
  //Serial.println(sensorValue);
  // superCollider
  Serial.print(sensorValue);
  Serial.print('a');
  Serial.print(sensorValue2);
  Serial.print('b');
  Serial.print(sensorValue3);
  Serial.print("c");
//  Serial.print(sensorValue4);
//  Serial.print("d");
//  Serial.println("");
}
