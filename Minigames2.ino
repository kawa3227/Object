#define X_AXIS A0
#define Y_AXIS A1


 char val; // Data received from the serial port
 int ledPin = 4; // Set the pin to digital I/O 4
 int Pin2 = 8;
 int Pin3 =13;

 int pressed = 0;
 int pressed2 = 0;

int tone1 = 0;
int tone2 = 0;
int tone3 = 0;

const int buttonPin = 7;
const int pinButton = 6;
const int button = 5;
 
void setup() 
{
  // initialize the serial communication:
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  pinMode(Pin2,OUTPUT);
   pinMode(Pin3,OUTPUT);
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  pinMode(buttonPin, INPUT_PULLUP);
   pinMode(pinButton,INPUT_PULLUP);

}

void loop() {
  // put your main code here, to run repeatedly:
 
Serial.print(analogRead(X_AXIS)); // adds '\n' (newline character)
Serial.print(',');
Serial.print(analogRead(Y_AXIS));
Serial.print(',');
int brightness = map(analogRead(A3), 0, 1023, 0, 255);

Serial.print(brightness);
Serial.print(',');
 byte buttonState = digitalRead(buttonPin);
 byte stateButton = digitalRead(pinButton);
 byte gameState = digitalRead(button);
  //if button pressed send 1 to port then read to processing
  //button 1
if(!buttonState == LOW)
{
  Serial.print(pressed);
}
else
{
  pressed = 1;
  Serial.print(pressed);
}
//button 2
Serial.print(',');
if(!stateButton == LOW ){
  Serial.println(pressed2);
}
else
{
  pressed2 = 1;
  Serial.println(pressed2);
}

val = Serial.read(); // read it and store it in val
    if (val == 'W') 
    { // If H was received
      tone(9,1000);
      delay(500);
      noTone(9);
      delay(10);
    }
    if (val == 'H' && tone1 == 0) 
    { // If H was received
      digitalWrite(ledPin, LOW); // turn the LED off
      tone(9,880);
      delay(500);
      noTone(9);
      delay(10);
      tone1 = 1;
    } 
   if(val == 'K' && tone2 == 0) 
   { // If H was received
      digitalWrite(Pin2,LOW);
      tone(9,880);
      delay(500);
      noTone(9);
      delay(10);
      tone2 = 1;
   } 
   if(val == 'J' && tone3 == 0) 
   { // If H was received
      digitalWrite(Pin3,LOW);
      tone(9,880);
      delay(500);
      noTone(9);
      delay(10);
      tone3 = 1;
  } 
  else 
  {
    if(tone1 == 1)
    {
      digitalWrite(ledPin, LOW);
    }
    else
    {
      digitalWrite(ledPin, HIGH); // Otherwise turn it On
    }
    if(tone2 == 1)
    {
      digitalWrite(Pin2, LOW);
    }
    else
    {
      digitalWrite(Pin2, HIGH); // Otherwise turn it On
    }
    if(tone3 == 1)
    {
      digitalWrite(Pin3, LOW);
    }
    else
    {
      digitalWrite(Pin3, HIGH); // Otherwise turn it On
    }
     noTone(9);
  }
  if (val == 'P') 
    {
      pressed = 0;
      tone1 = 0;
      tone2 = 0;
      tone3 = 0;
    }
    if (val == 'G' ) 
    {
      pressed2 = 0;
      tone1 = 0;
      tone2 = 0;
      tone3 = 0;
    }

}
