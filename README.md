# PulseSensor
Example Arduino and Processing code to plot a pulse and calculate a heart rate using a pulse sensor

## Description:
This example shows how to use the a cheap ADC pulse sensor.

The processing program takes the ADC values from the pulse sensor and plots the pulse.
It also calculates and shows the bpm (beats per minute) using a very crude algorithm
and running average.
 
The Arduino sketch reads the ADC value on the Arduino.
The sketch blinks the user LED for each pulse,
(the threshold is set at 500 out of 1024 for the 10 bit adc value,
you may need to adjust this to get good results).
 
The output for the sensor is sent to the serial port. This output can be read to graph the pulse.

The sketch uses a pulse sensor from:
http://pulsesensor.com/

A screenshot of the output is also provided.

## How to use
Simple program the Arduino with the Arduino sketch and run the processing sketch.

Hookup:
* Plus (+) -> 3.3V
* Minus (-) -> GND
* Signal (S) -> A0

NOTE: THIS CODE ASSUMES YOUR ARDUINO/MICROCONTROLLER IS THE FIRST LISTED COM PORT!
IF THIS IS NOT THE CASE YOU NEED TO CHANGE THE CHOSEN COM PORT:
myPort = new Serial(this, Serial.list()[0], 9600);
Serial.list()[0] CHANGE 0 TO THE INDEX OF YOUR COM PORT
(OR INCREMENT IT UNTIL IT WORKS)

## Copyright & License

Copyright 2016 Krugaroo 

License: MIT License

Copyright (c) 2015 Michael Kruger, Krugaroo Interactive Technology

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
