int sap_flow_pin = 2;
int water_flow_pin = 3;
int hi_press_rly_pin = 6;
int sump_rly_pin = 7;
int spare_rly_pin = 8;
int enable_pin = 11;
int estop_mon_pin = 4;
int level_sw_pin = 5;
int enabled_mon_pin = 10;

boolean hi_press_rly = false;
boolean sump_rly = false;
boolean spare_rly = false;
boolean enable = false;
boolean estop_mon = false;
boolean level_sw = false;
boolean enabled_mon = false;

double flowRate;
volatile int count; //This integer needs to be set as volatile to ensure it updates correctly during the interrupt process.  
long int prev_time;
long int prev_count;
long int delta_count;
double k_factor;
double cnts_per_gal;
double gallons;

void setup() {
  // put your setup code here, to run once:
  pinMode(sap_flow_pin, INPUT);
  attachInterrupt(0, Flow, RISING);  
  Serial.begin(9600);
  cnts_per_gal = 2566;
  k_factor = 1440 / cnts_per_gal; //reading every 100ms  //was 7200 @ 500ms
  
  pinMode(hi_press_rly_pin, OUTPUT);   //HI_PRESS_RLY
  pinMode(sump_rly_pin, OUTPUT);   //SUMP_RLY
  pinMode(spare_rly_pin, OUTPUT);   //SPARE_RLY
  pinMode(enable_pin, OUTPUT);   //ENABLE
  pinMode(estop_mon_pin, INPUT_PULLUP);  //E-STOP_MON
  pinMode(level_sw_pin, INPUT_PULLUP);  //LEVEL_SW
  pinMode(enabled_mon_pin, INPUT_PULLUP);  //ENABLED?
}
void loop() {
  delta_count = count - prev_count;
  prev_count = count;
  gallons = count / cnts_per_gal;
  flowRate = delta_count * k_factor;
  Serial.print(gallons);
  Serial.print(", ");
  Serial.print(flowRate);
  Serial.print(", ");
  Serial.print(digitalRead(4));
  Serial.print(", ");
  Serial.println(digitalRead(10));
  delay(100);
  
  while (Serial.available() > 0) {
    String command = Serial.readStringUntil('/');
    
    if (command == "hi_press_rly") {
      digitalWrite(hi_press_rly_pin, Serial.parseInt());
    }
  }
}

void digitalCommand() {
    
  int digitalIndex = Serial.parseInt();
    
  int digitalValue = Serial.parseInt();
    
  int pin = digitalIndex;
    
  digitalWrite(pin, digitalValue);
  
}

void Flow()
{
   count++; //Every time this function is called, increment "count" by 1
}
