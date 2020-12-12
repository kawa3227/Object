/**
 * Simple Write. 
 * 
 * Check if the mouse is over a rectangle and writes the status to the serial port. 
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

//joystick variables
float xPos = 500; // horizontal position of the graph
float yPos = 500; // vertical position of the graph
float buttonState = 1;
int score = 0;
int lives = 3;
int life = 0;
int pastscore = -1;
float rx = random(900);
float ry = random(900);
int count = 0;

float w = random(50,300);

int tone = 0;
int tone2 = 0;
int tone3 = 0;

float ColorPicker = 0;
float Button1 = 0;
float Button2 = 0;
int backgroundColor = 1;

float shape1x = random(900);
float shape1y = random(900);

float color1 = random(255);
float color2 = random(255);
float color3 = random(255);

void setup() 
{
  size(1023, 1023);
  
  String portName = Serial.list()[0];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  background(255);
  fill(0);

}
  
void draw() {
  //can put that this is the envoirment if button 1 is clicked - 
  
   background(0);
   fill(255,0,255);
   PFont Font;
   Font = createFont("Calibri-Light-48.vlw", 72);
   textFont(Font);
   text("Game 1 (button 1)", 200, 300); 
   text("Game 2 (button 2)", 200, 500);
  //button 2 can be in another if statement and the be a different envoirnment
if(Button1 == 1){
  
  if(backgroundColor == 1)
  {
    background(ColorPicker, color1, color2);
    
    fill(color1, ColorPicker, color2);
    stroke(0);
    rect(int(rx),int(ry),50,50);
    
    //decoy
    fill(color1,color2,ColorPicker);
    rect(shape1x, shape1y, 50, 50);
    
    fill(color1, color3, color2);
    stroke(0);
    circle(xPos, yPos, 50);
    
  }
  else if(backgroundColor == 2)
  {
    background(color1, ColorPicker, color2);
    fill(color1,color2,ColorPicker);
    
    stroke(0);
    rect(int(rx),int(ry),50,50);
    
    fill(ColorPicker, color1, color2);
    rect(shape1x, shape1y, 50, 50);
    
    fill(color1, color2, color3);
    stroke(0);
    circle(xPos, yPos, 50);
  }
  else if(backgroundColor == 3)
  {
    background(color1,color2,ColorPicker);
    fill(ColorPicker, color1, color2);
    
    stroke(0);
    rect(int(rx),int(ry),50,50);
    
    fill(color1, ColorPicker, color2);
    rect(shape1x, shape1y, 50, 50);
    
    fill(color3, color1, color2);
    stroke(0);
    circle(xPos, yPos, 50);
  }
  


  if (dist(shape1x, shape1y, xPos, yPos) < 50 && life != 1)
  {
      lives--;
      if(lives < 1)
      {
        count = -1;
      }
      else
      {
        life = 1;
        count = 1;
      }
  }
  
  if (dist(xPos,yPos, rx, ry) < 50 && life != 1 ) // If mouse is over ending square
  {                    // change color and
    float check1 = color3 + 20;
    float check2 = color3 - 20;
    if(ColorPicker < check1 && ColorPicker > check2)// send an H to indicate mouse is over ending square
    {
      count = 1;
    }
    else
    {
      lives--;
      if(lives < 1)
      {
        count = -1;
      }
      else
      {
        life = 1;
        count = 1;
      }
    }
  }
  if (life == 1)
  {
    background(0);
    PFont font;
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Wrong color!", 300, 100); 
    font = createFont("Calibri-Light-48.vlw", 42);
    textFont(font);
    text("Lives left: ", 400, 200);
    text(lives, 600, 200);
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Continue", 400, 500);
    if(lives == 2 && tone == 0)
    {
      tone = 1;
      myPort.write('H');
    }
    if(lives == 1 && tone2 == 0)
    {
      tone2 = 1;
      myPort.write('K');
    }
    circle(xPos, yPos, 50);
    
    if (dist(xPos,yPos, 500, 500) < 80)
    {
      life = 0;
    }
        
  }
  if (count > 0)
  {
    score++;
    myPort.write('W');
    
    //change position of end square
    rx = random(900);
    ry = random(900);
    
    shape1x = random(900);
    shape1y = random(900);
    
    color1 = random(255);
    color2 = random(255);
    color3 = random(255);
    
    count = 0;
    if(backgroundColor == 3)
    {
      backgroundColor = 1;
    }
    else 
    {
      backgroundColor++;
    }
   
  }
  if (count < 0 && life != 1)
  {
    if(lives == 0 && tone3 == 0)
    {
      tone3 = 1;
      myPort.write('J');
    }
    background(0);
    PFont font;
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Game Over",300,100);
    
    font = createFont("Calibri-Light-48.vlw", 42);
    textFont(font);
    text("Score: ", 400, 200);
    text(score, 600, 200);
    
    text("Restart?", 300, 500);
    text("Yes", 500, 500);
    text("No", 70, 500);
    
    circle(xPos, yPos, 50);
    
    if (dist(xPos,yPos, 500, 500) < 20)
    {
      count = 0;
      life = 0;
      lives = 3;
      score = 0;
    }
    if (dist(xPos,yPos, 600, 500) < 30)
    {
        myPort.write('P');
        count = 0;
      life = 0;
      lives = 3;
      score = 0;
    }
    
  }
 
 }
 if(Button2 == 1)
 {
   float sizePicker = ColorPicker;
  if(backgroundColor == 1)
  {
    background(0, color1, color2);
    fill(color1, ColorPicker, color2);
    
    stroke(0);
    square(int(rx),int(ry),int(w));
    
    //decoy
    fill(color1,color2,ColorPicker);
    square(int(rx), int(ry), int(w));
    
    fill(color1, color3, color2);
    stroke(0);
    square(xPos, yPos, sizePicker);
    
  }
  else if(backgroundColor == 2)
  {
    background(color1, 0, color2);
    fill(color1, 0, color2);
    
    stroke(0);
    square(int(rx),int(ry),int(w));
    
    //decoy
    fill(color1,color2,ColorPicker);
    square(int(rx), int(ry), int(w));
    
    fill(color1, color3, color2);
    stroke(0);
    square(xPos, yPos, sizePicker);
  }
  else if(backgroundColor == 3)
  {
    background(color1,color2,ColorPicker);
    fill(ColorPicker, color1, color2);
    
    stroke(0);
    square(int(rx),int(ry),int(w));
    
    //decoy
    fill(color1,color2,ColorPicker);
    square(int(rx), int(ry), int(w));
    
    fill(color1, color3, color2);
    stroke(0);
    square(xPos, yPos, sizePicker);
  }
  


  if (dist(rx, ry,xPos, yPos) < 50 && life != 1)
  {
      lives--;
      if(lives < 1)
      {
        count = -1;
      }
      else
      {
        life = 1;
        count = 1;
      }
  }
  
  if (dist(xPos,yPos, rx, ry) < 50 && life != 1 ) // If mouse is over ending square
  {                    // change color and
    float check1 = w + 30;
    float check2 = w - 30;
    if(sizePicker < check1 && sizePicker > check2)// send an H to indicate mouse is over ending square
    {
      count = 1;
    }
    else
    {
      lives--;
      if(lives < 1)
      {
        count = -1;
      }
      else
      {
        life = 1;
        count = 1;
      }
    }
  }
  if (life == 1)
  {
    background(0);
    PFont font;
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Wrong size!", 300, 100); 
    font = createFont("Calibri-Light-48.vlw", 42);
    textFont(font);
    text("Lives left: ", 400, 200);
    text(lives, 600, 200);
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Continue", 400, 500);
    if(lives == 2 && tone == 0)
    {
      tone = 1;
      myPort.write('H');
    }
    if(lives == 1 && tone2 == 0)
    {
      tone2 = 1;
      myPort.write('K');
    }
    circle(xPos, yPos, 50);
    
    if (dist(xPos,yPos, 500, 500) < 80)
    {
      life = 0;
    }
        
  }
  if (count > 0)
  {
    score++;
    
    //change position of end square
    rx = random(900);
    ry = random(900);
    w = random(50,300);
    
    shape1x = random(900);
    shape1y = random(900);
    
    color1 = random(255);
    color2 = random(255);
    color3 = random(255);
    
    count = 0;
    if(backgroundColor == 3)
    {
      backgroundColor = 1;
    }
    else 
    {
      backgroundColor++;
    }
   
  }
  if (count < 0 && life != 1)
  {
    if(lives == 0 && tone3 == 0)
    {
      tone3 = 1;
      myPort.write('J');
    }
    background(0);
    PFont font;
    font = createFont("Calibri-Light-48.vlw", 72);
    textFont(font);
    text("Game Over",300,100);
    
    font = createFont("Calibri-Light-48.vlw", 42);
    textFont(font);
    text("Score: ", 400, 200);
    text(score, 600, 200);
    
    text("Restart?", 300, 500);
    text("Yes", 500, 500);
    text("No", 600, 500);
    
    circle(xPos, yPos, w);
    
    if (dist(xPos,yPos, 500, 500) < 20)
    {
      count = 0;
      life = 0;
      lives = 3;
      score = 0;
    }
    
  }
 }
}

void serialEvent (Serial myPort) //Positioning of Character
{
// get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) 
  {
    String[] splitData = inString.split(",");
    //println(splitData);
    float xData = float(splitData[0]);
    float yData = float(splitData[1]);
    ColorPicker = float(splitData[2]);
    Button1 = float(splitData[3]); 
    Button2 =float(splitData[4]);
    
    if(xData > 510)
    {
      xPos = xPos + 5;
    }
    if(xData < 490)
    {
      xPos = xPos - 5;
    }
    if(yData > 700)
    {
      yPos = yPos + 5;
    }
    if(yData < 490)
    {
      yPos = yPos - 5;
    }
    
    println("x data" + xPos);
    println("y data" + yPos);
  }

}
