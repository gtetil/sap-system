//flow meter pins (interrupts)
int sap_flow_pin = 2;
int water_flow_pin = 3;

//digital output pins
int hi_press_rly_pin = 6;
int sump_rly_pin = 7;
int spare_rly_pin = 8;
int enable_pin = 11;

//digital input pins
int estop_mon_pin = 4;
int level_sw_pin = 5;
int enabled_mon_pin = 10;

//digital output states
int hi_press_rly = 0;
int sump_rly = 0;
int spare_rly = 0;

//digital input states
int estop_mon = 0;
int level_sw = 0;
int enabled_mon = 0;

//config
int level_sw_mode = 0;
int min_flow = 0;
int hp_pump_on_delay = 0;

//sap flow variables
double sap_flow;
volatile int sap_count; //This integer needs to be set as volatile to ensure it updates correctly during the interrupt process.
long int sap_prev_count;
long int sap_delta_count;
double sap_k_factor;
double sap_cnts_per_gal = 2566;
double sap_gallons;

//water flow variables
double water_flow;
volatile int water_count; //This integer needs to be set as volatile to ensure it updates correctly during the interrupt process.
long int water_prev_count;
long int water_delta_count;
double water_k_factor;
double water_cnts_per_gal = 2566;
double water_gallons;

//total flow
double total_flow;
double total_gallons;
double efficiency;

//auto mode
int run_auto;

void setup() {
  //serial setup
  Serial.begin(9600);
  
  //setup flow meter interrupts
  pinMode(sap_flow_pin, INPUT);
  attachInterrupt(0, sapFlow, RISING);
  pinMode(water_flow_pin, INPUT);
  attachInterrupt(1, waterFlow, RISING);  
  
  pinMode(hi_press_rly_pin, OUTPUT);   //HI_PRESS_RLY
  pinMode(sump_rly_pin, OUTPUT);   //SUMP_RLY
  pinMode(spare_rly_pin, OUTPUT);   //SPARE_RLY
  pinMode(enable_pin, OUTPUT);   //ENABLE
  pinMode(estop_mon_pin, INPUT_PULLUP);  //E-STOP_MON
  pinMode(level_sw_pin, INPUT_PULLUP);  //LEVEL_SW
  pinMode(enabled_mon_pin, INPUT_PULLUP);  //ENABLED?
}

void loop() {
  
  Serial.print(total_gallons);
  Serial.print(", ");
  Serial.print(total_flow);
  Serial.print(", ");
  Serial.print(digitalRead(4));
  Serial.print(", ");
  Serial.println(digitalRead(10));
  delay(100);

  calcSapFlow();
  calcWaterFlow();
  calcTotalFlow();
  checkSerial();
  digitalInputs();

  if (enabled_mon == 0) {  //if estop circuit opens, turn off all digital outputs
    estop();
  }
  
}

void calcTotalFlow() {
  total_flow = sap_flow + water_flow;
  total_gallons = sap_gallons + water_gallons;
  efficiency = (sap_flow / total_flow) * 100;
}

void calcSapFlow() {
  sap_delta_count = sap_count - sap_prev_count;
  sap_prev_count = sap_count;
  sap_gallons = sap_count / sap_cnts_per_gal;
  sap_k_factor = 36000 / sap_cnts_per_gal; //reading every 100ms  //was 7200 @ 500ms
  sap_flow = sap_delta_count * sap_k_factor;
}

void calcWaterFlow() {
  water_delta_count = water_count - water_prev_count;
  water_prev_count = water_count;
  water_gallons = water_count / water_cnts_per_gal;
  water_k_factor = 36000 / water_cnts_per_gal; //reading every 100ms  //was 7200 @ 500ms
  water_flow = water_delta_count * water_k_factor;
}

void digitalInputs() {
  estop_mon = !digitalRead(estop_mon_pin);
  level_sw = !digitalRead(level_sw_pin);
  enabled_mon = !digitalRead(enabled_mon_pin);
}

void checkSerial() {
  while (Serial.available() > 0) {
    String command = Serial.readStringUntil('/');
    
    if (command == "digital_output") {
      String tag = Serial.readStringUntil('/');
      int state = Serial.parseInt();
      digitalOutput(tag, state);
    }
    else if (command == "app_config") {
      String tag = Serial.readStringUntil('/');
      int state = Serial.parseInt();
      appConfig(tag, state);
    }
    else if (command == "flow_config") {
      String tag = Serial.readStringUntil('/');
      double value = Serial.readStringUntil('/').toFloat();
      flowConfig(tag, value);
    }
    else if (command == "run_auto") {
      run_auto = Serial.parseInt();
      if (run_auto == 0) {
        estop();  //if auto mode is turned off, turn off all outputs
      }
      else {
        runAuto();
      }
    }
  }
}

void runAuto() {
  digitalOutput("sump_rly", 1);
}

void flowConfig(String tag, double value) {
  if (tag == "sap_cnts_per_gal") {
    sap_cnts_per_gal = value;
  }
  else if (tag == "water_cnts_per_gal") {
    water_cnts_per_gal = value;
  }
  else if (tag == "set_sap_gal") {
    sap_gallons = value;
  }
  else if (tag == "set_water_gal") {
    water_gallons = value;
  }
}  

void appConfig(String tag, int state) {
  if (tag == "level_sw_mode") {
    level_sw_mode = state;
  }
  else if (tag == "min_flow") {
    min_flow = state;
  }
  else if (tag == "hp_pump_on_delay") {
    hp_pump_on_delay = state;
  }
}

void digitalOutput(String tag, int state) {
  if (tag == "hi_press_rly") {
    if (sump_rly == 0) {
      state = 0;  //if sump pump is off, never turn on high pressure pump
    }
    hi_press_rly = state;
    digitalWrite(hi_press_rly_pin, state);
  }
  else if (tag == "sump_rly") {
    sump_rly = state;
    digitalWrite(sump_rly_pin, state);
    if (state == 0) {
      digitalWrite(hi_press_rly_pin, 0); //turn of high pressure pump if sump is turned off
    }
  }
  else if (tag == "spare_rly") {
    spare_rly = state;
    digitalWrite(spare_rly_pin, state);
  }
  else if (tag == "enable") { //this is a momentary switch to seal estop circuit
    digitalWrite(enable_pin, 1);
    delay(100);
    digitalWrite(enable_pin, 0);
  }
}

void estop() {
  digitalOutput("hi_press_rly", 0);
  digitalOutput("sump_rly", 0);
  digitalOutput("spare_rly", 0);
}

void sapFlow() {
   sap_count++; //Every time this function is called, increment "count" by 1
}

void waterFlow() {
   water_count++; //Every time this function is called, increment "count" by 1
}
