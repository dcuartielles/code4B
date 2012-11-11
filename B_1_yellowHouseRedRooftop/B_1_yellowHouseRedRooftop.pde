/* Yellow House Red Rooftop
 *
 * Creates a yellow house which size
 * can be controlled from an Arduino board
 * or using the mouse
 *
 * (c) 2012 B & D Cuartielles
 * Made at CoderDojo Malmo
 *
 * References:
 *
 * - RGB colors taken from: http://web.njit.edu/~kevin/rgb.txt.html
 *
 */

import processing.serial.*;

boolean mouseControl = true;

float s = 1; // scale

Serial myPort; 

void setup() {
  size(800,600);
  if(mouseControl) println("Controlled by mouseX");
  else {
    myPort = new Serial(this, Serial.list()[0], 9600);
    println ("Controlled from the Serial port");
  }
}

void draw() {
  background(200);
  noStroke();
  if (mouseControl) {
    s = (width - mouseX)/100;
  } else {
    if(myPort.available() > 0) {
      int val = myPort.read();
      s = (255 - val) / 100;
    }
  }
  float w = 200*s/2; // w - house's Width

  // the facade
  pushMatrix();
  fill(255,215,0);
  translate(width/2-w/2,height/2-w/2);
  rect(0,0,w,w);
  popMatrix();
  
  // the rooftop
  pushMatrix();
  fill(255,0,0);
  translate(width/2-3*w/4,height/2-w);
  triangle(3*w/4,0,0,w/2,3*w/2,w/2);
  popMatrix();
  
  // the door
  pushMatrix();
  fill(184,134,11);
  translate(width/2-w/8,height/2+w/8);
  ellipse(w/8,w/8,w/4,w/4);
  rect(0,w/8,w/4,w/4);
  popMatrix();
  
  // the windows
  pushMatrix();
  fill(255,255,255);
  stroke(0);
  strokeWeight(s);
  translate(width/2-3*w/8,height/2-3*w/8);
  rect(0,w/8,w/4,w/4);
  rect(w/2,w/8,w/4,w/4);
  popMatrix();
  
}
