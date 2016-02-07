/*
* Name: PulseSensorArduino.ino
* Author: Michael Kruger
* Brief:
* 
* This example sketch shows how to use the Pulse Sensor. 
* The sketch blinks the user id for each pulse,
* (the threshold is set at 500 out of 1024 for the 10 bit adc value,
* you may need to adjust this to get good results).
* 
* The output for the sensor is sent to the serial port. This output can be read to graph the pulse.
* See the Processing sketch for an example.
* 
* The sketch uses a pulse sensor from:
* http://pulsesensor.com/
* 
* Hookup:
* + -> 3.3V
* - -> GND
* S -> A0
* 
* License: MIT License
*
* Copyright (c) 2016 Michael Kruger, Krugaroo
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
void setup() {
  // initialize the serial communication:
  Serial.begin(9600);

  pinMode(13, OUTPUT);
}

void loop() {
  // get the analog value
  int analogValue = analogRead(A0);
  
  // send the value of analog input 0:
  Serial.println(analogValue);

  // if the value is above 500 treat it as a pulse
  // blink the led for each pulse
  if(analogValue>500)
  {
    digitalWrite(13, HIGH);
  }
  else
  {
    digitalWrite(13, LOW);
  }

  
  // wait a bit for the analog-to-digital converter
  // to stabilize after the last reading:
  delay(2);
}
