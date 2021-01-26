int sensorPin = A1;    // select the input pin for the potentiometer
int sensorPin2 = A2;    // select the input pin for the potentiometer
int sensorValue = 0;  // variable to store the value coming from the sensor
int sensorValue2 = 0; 

void setup() {
   // initialize serial:
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
//  sensorValue2 = analogRead(sensorPin2);
  delay(500);
  // processing
  //Serial.println(sensorValue);
  // superCollider
  Serial.print(sensorValue);
  Serial.print('a');
//  Serial.print(sensorValue2);
//  Serial.println(" ");
}
