// Test-Teensy sensorValue
int sensorPin = 1;    // select the input pin for the potentiometer
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
   // initialize serial:
 // analogReference(EXTERNAL); 
  Serial.begin(9600);
}

void loop() {
  sensorValue = analogRead(sensorPin);
  
  delay(500);
  Serial.print("sensorValue = ");
  Serial.println(sensorValue);
}
