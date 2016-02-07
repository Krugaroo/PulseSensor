/*
* Name: PulseSensorArduino.ino
* Author: Michael Kruger
* Brief:
* 
* This program takes the ADC values from the pulse sensor and plots the pulse.
* It also calculates and shows the bpm (beats per minute) using a very crude algorithm.
* and running average.
* 
* See the Arduino sketch in this project for code to read the ADC value on the Arduino.
*
* NOTE: THIS CODE ASSUMES YOUR ARDUINO/MICROCONTROLLER IS THE FIRST LISTED COM PORT!
* IF THIS IS NOT THE CASE YOU NEED TO CHANGE THE CHOSEN COM PORT:
* myPort = new Serial(this, Serial.list()[0], 9600);
* Serial.list()[0] CHANGE 0 TO THE INDEX OF YOUR COM PORT
* (OR INCREMENT IT UNTIL IT WORKS)
* 
* The sketch uses a pulse sensor from:
* http://pulsesensor.com/
* 
* The plotting of ADC values is derived from the (https://www.arduino.cc/en/Tutorial/Graph) by Tom Igoe
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

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph

boolean pulse = false;
int lastpulsetime = 0;
int currentpulsetime = 0;
int bpmAvg = 0;
int[] bmpSamples = {0,0,0,0,0};
int bmpPos = 0;

void setup () {
   // set the window size:
   size(1200, 600);
  
   // List all the available serial ports
   // if using Processing 2.1 or later, use Serial.printArray()
   println(Serial.list());
  
   // The Arduino/Microcontroller will have an COM port.
   // Open the correct COM port in this case the first one. Serial.list()[0].
   myPort = new Serial(this, Serial.list()[0], 9600);
  
   // don't generate a serialEvent() unless you get a newline character:
   myPort.bufferUntil('\n');
  
   // set inital background:
   background(0);
   
   /* drawing the initial bpm */
   fill(0,0,0);
   rect(0, 0, 250, 70);
   fill(0,255,0);
   String bpm = bpmAvg + " bpm";
   textSize(48);
   text(bpm,10,50);
}
 
 
 void draw () {
 // everything happens in the serialEvent()
}

//this function is called when data has arrived on the COM port with a newline
 void serialEvent (Serial myPort) {
   // get the ASCII string:
   String inString = myPort.readStringUntil('\n');
  
   if (inString != null) 
   {
     // trim off any whitespace:
     inString = trim(inString);
     // convert to an int and map to the screen height:
     float inADC = float(inString);
     //println(inByte);
     float inByte = map(inADC, 0, 1023, 0, height-100);
     
     /* threshold is 500 if above this heart beat took place */
     /* if not still in last pulse */
     if(inADC>500 && !pulse)
     {
       /* we have a pulse! */
       pulse = true;
       currentpulsetime= millis();
       
       /* clear text*/
       fill(0,0,0);
       rect(0, 0, 250, 70);
       
       /* the time difference between two pulse is used to estimate the bpm */
       /* 1sec/(pulse time difference) = number of pulses in a second */
       /* number of pulses in a second * 60 = beats per minute */
       int bpmEst = parseInt(1000.0/(currentpulsetime-lastpulsetime)*60.0);
       if(bpmEst<250)
       {
         /* keep track of how many valid samples are in our running average*/
         if(bmpPos<5){bmpPos++;}
         
         /* shift out oldest sample and add newest sample */
         bmpSamples[0] = bmpSamples[1];
         bmpSamples[1] = bmpSamples[2];
         bmpSamples[2] = bmpSamples[3];
         bmpSamples[3] = bmpSamples[4];
         bmpSamples[4] = bpmEst;
         
         /* update the average = sum of samples / num samples */
         bpmAvg = (bmpSamples[0] + bmpSamples[1] +  bmpSamples[2] +  bmpSamples[3] +  bmpSamples[4])/bmpPos;
         
         /* Draw bmp */
         String bpm = bpmAvg + " bpm";
         fill(0,255,0); //green text
         textSize(48);
         text(bpm,10,50);
       }
       
       /*update the last time to start measuring until next peak. */
       lastpulsetime = currentpulsetime;
     }
     
     /* No pulse in 3s clear our average and samples bpm = 0*/
     if(millis()-lastpulsetime > 3000)
     {
       bpmAvg = 0;
       bmpPos = 0;
       bmpSamples[0] = 0;
       bmpSamples[1] = 0;
       bmpSamples[2] = 0;
       bmpSamples[3] = 0;
       bmpSamples[4] = 0;
     }
     
     /* once measured value is below 400 pulse is over and can start waiting for next pulse*/
     if(inADC<400)
     {
       pulse=false;
     }
    
     // draw the line:
     stroke(0,255,0);
     line(xPos, height-inByte, xPos, height-inByte-1);
    
     // at the edge of the screen, go back to the beginning:
     if (xPos >= width)
     {
       xPos = 0;
       background(0);
       
       /* when redrawing screen also redraw the bpm */
       fill(0,0,0);
       rect(0, 0, 250, 70);
       fill(0,255,0);
       String bpm = bpmAvg + " bpm";
       textSize(48);
       text(bpm,10,50);
     }
     else 
     {
       // increment the horizontal position:
       xPos++;
     }
     
   }
 }
