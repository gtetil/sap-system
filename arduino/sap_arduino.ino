int flowPin = 2;    //This is the input pin on the Arduino
double flowRate;    //This is the value we intend to calculate. 
volatile int count; //This integer needs to be set as volatile to ensure it updates correctly during the interrupt process.  
long int prev_time;
long int prev_count;
long int delta_count;
double k_factor;
double cnts_per_gal;
double gallons;

void setup() {
  // put your setup code here, to run once:
  pinMode(flowPin, INPUT);           //Sets the pin as an input
  attachInterrupt(0, Flow, RISING);  //Configures interrupt 0 (pin 2 on the Arduino Uno) to run the function "Flow"  
  Serial.begin(9600);
  cnts_per_gal = 2566;
  k_factor = 7200 / cnts_per_gal; //reading every 500ms
}
void loop() {
  delta_count = count - prev_count;
  prev_count = count;
  gallons = count / cnts_per_gal;
  flowRate = delta_count * k_factor;
  Serial.print(gallons);
  Serial.print(", ");
  Serial.println(flowRate);
  delay(500);
}

void Flow()
{
   count++; //Every time this function is called, increment "count" by 1
}
