EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:arduino
LIBS:sap-pcb-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L arduino_mini U1
U 1 1 57BF6188
P 5300 3300
F 0 "U1" H 5500 1850 70  0000 C CNN
F 1 "Arduino_Nano" H 5800 1750 70  0000 C CNN
F 2 "sap-pcb:ARDUINO_NANO" H 5300 3250 60  0001 C CNN
F 3 "" H 5300 3300 60  0001 C CNN
	1    5300 3300
	1    0    0    -1  
$EndComp
Text Notes 2050 2000 2    60   ~ 0
12V_IN
Text Notes 2050 2100 2    60   ~ 0
COM
Text Notes 2050 2200 2    60   ~ 0
COM
$Comp
L CONN_01X04 E-STOP1
U 1 1 57BF6965
P 2150 2900
F 0 "E-STOP1" H 2150 3150 50  0000 C CNN
F 1 "CONN_01X04" H 2150 2650 50  0000 C CNN
F 2 "sap-pcb:4-PIN_CONN" H 2150 2900 50  0001 C CNN
F 3 "" H 2150 2900 50  0000 C CNN
	1    2150 2900
	-1   0    0    -1  
$EndComp
Text Notes 2050 2900 2    60   ~ 0
E-STOP_1 / CR-
Text Notes 2050 3000 2    60   ~ 0
OVR_PRS_1 / E-STOP_2
Text Notes 2050 2800 2    60   ~ 0
CR+
Text Notes 2050 3100 2    60   ~ 0
CR_1 / OVER_PRS_2
Text Notes 9900 1750 0    60   ~ 0
5V
Text Notes 9900 1850 0    60   ~ 0
5V
Text Notes 9900 1950 0    60   ~ 0
SAP_FLOW
Text Notes 9900 2050 0    60   ~ 0
WATER_FLOW
$Comp
L GND #PWR01
U 1 1 57BF702C
P 2750 5400
F 0 "#PWR01" H 2750 5150 50  0001 C CNN
F 1 "GND" H 2750 5250 50  0000 C CNN
F 2 "" H 2750 5400 50  0000 C CNN
F 3 "" H 2750 5400 50  0000 C CNN
	1    2750 5400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X03 POWER1
U 1 1 588FC1DA
P 2150 2050
F 0 "POWER1" H 2150 2250 50  0000 C CNN
F 1 "CONN_01X03" H 2150 1850 50  0000 C CNN
F 2 "sap-pcb:3-PIN_CONN" H 2150 2050 50  0001 C CNN
F 3 "" H 2150 2050 50  0000 C CNN
	1    2150 2050
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X15 CONTROL1
U 1 1 588FCA10
P 9800 2400
F 0 "CONTROL1" H 9800 3200 50  0000 C CNN
F 1 "CONN_01X15" H 9800 1600 50  0000 C CNN
F 2 "sap-pcb:15-PIN_CONN" H 9800 2400 50  0001 C CNN
F 3 "" H 9800 2400 50  0000 C CNN
	1    9800 2400
	1    0    0    -1  
$EndComp
Text Notes 9900 2150 0    60   ~ 0
COM
Text Notes 9900 2250 0    60   ~ 0
COM
Text Notes 9900 2350 0    60   ~ 0
COM
Text Notes 9900 2450 0    60   ~ 0
COM
Text Notes 9900 2550 0    60   ~ 0
HI_PRESS_RLY
Text Notes 9900 2650 0    60   ~ 0
SUMP_RLY
Text Notes 9900 2750 0    60   ~ 0
SPARE_RLY
Text Notes 9900 2850 0    60   ~ 0
E-STOP_MON
Text Notes 9900 2950 0    60   ~ 0
LEVEL_SW
Text Notes 9900 3050 0    60   ~ 0
SPARE_DIO
Text Notes 9900 3150 0    60   ~ 0
SPARE_DIO
NoConn ~ 2350 2850
NoConn ~ 2350 2950
$Comp
L DROK_DC_DC_CONVERTOR P1
U 1 1 588FD125
P 3550 2050
F 0 "P1" H 3550 2250 50  0000 C CNN
F 1 "DROK_DC_DC_CONVERTER" H 3550 1950 50  0000 C CNN
F 2 "sap-pcb:DROK_DC_DC_CONVERTER" H 3550 850 50  0001 C CNN
F 3 "" H 3550 850 50  0000 C CNN
	1    3550 2050
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 588FD64F
P 3600 4150
F 0 "R1" V 3680 4150 50  0000 C CNN
F 1 "1k" V 3600 4150 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3530 4150 50  0001 C CNN
F 3 "" H 3600 4150 50  0000 C CNN
	1    3600 4150
	0    1    1    0   
$EndComp
Text Notes 3450 3200 2    60   ~ 0
E-STOP COM
$Comp
L D D2
U 1 1 588FEA03
P 8200 2300
F 0 "D2" H 8200 2200 50  0000 C CNN
F 1 "D" H 8200 2200 50  0001 C CNN
F 2 "Diodes_ThroughHole:D_A-405_P10.16mm_Horizontal" H 8200 2300 50  0001 C CNN
F 3 "" H 8200 2300 50  0000 C CNN
	1    8200 2300
	-1   0    0    1   
$EndComp
$Comp
L D D3
U 1 1 588FEBD4
P 8200 3050
F 0 "D3" H 8200 2950 50  0000 C CNN
F 1 "D" H 8200 2950 50  0001 C CNN
F 2 "Diodes_ThroughHole:D_A-405_P10.16mm_Horizontal" H 8200 3050 50  0001 C CNN
F 3 "" H 8200 3050 50  0000 C CNN
	1    8200 3050
	-1   0    0    1   
$EndComp
$Comp
L D D4
U 1 1 588FEC48
P 8200 3800
F 0 "D4" H 8200 3700 50  0000 C CNN
F 1 "D" H 8200 3700 50  0001 C CNN
F 2 "Diodes_ThroughHole:D_A-405_P10.16mm_Horizontal" H 8200 3800 50  0001 C CNN
F 3 "" H 8200 3800 50  0000 C CNN
	1    8200 3800
	-1   0    0    1   
$EndComp
Wire Wire Line
	2350 1950 3150 1950
Wire Wire Line
	2350 2050 3150 2050
Wire Wire Line
	2350 2150 2750 2150
Wire Wire Line
	2750 2050 2750 5400
Connection ~ 2750 2050
Connection ~ 2750 2150
Wire Wire Line
	3950 2050 4100 2050
Wire Wire Line
	4100 2050 4100 2250
Wire Wire Line
	4100 2250 2750 2250
Connection ~ 2750 2250
Wire Wire Line
	4150 2750 2350 2750
Wire Wire Line
	4150 1850 4150 2750
Wire Wire Line
	4150 1950 3950 1950
Wire Wire Line
	3650 2850 3650 2750
Connection ~ 3650 2750
Wire Wire Line
	2350 3050 2500 3050
Wire Wire Line
	2500 3050 2500 5100
Wire Wire Line
	2500 3250 3650 3250
Wire Wire Line
	3650 3150 3650 3450
Connection ~ 3650 3250
Wire Wire Line
	3650 3850 3650 4000
Wire Wire Line
	3650 4000 2750 4000
Connection ~ 2750 4000
Wire Wire Line
	3350 3650 3250 3650
Wire Wire Line
	3250 3650 3250 4150
Wire Wire Line
	3250 4150 3450 4150
Wire Wire Line
	5150 2150 5150 1500
Wire Wire Line
	5150 1500 3050 1500
Wire Wire Line
	3050 1500 3050 1950
Connection ~ 3050 1950
Wire Wire Line
	5300 4850 5300 5250
Wire Wire Line
	9500 5250 2750 5250
Connection ~ 2750 5250
Wire Wire Line
	3750 4150 4250 4150
Wire Wire Line
	4250 4150 4250 1950
Wire Wire Line
	4250 1950 6200 1950
Wire Wire Line
	6200 1950 6200 2850
Wire Wire Line
	6200 2850 6000 2850
Wire Wire Line
	7350 2700 7400 2700
Wire Wire Line
	2500 5100 8000 5100
Connection ~ 2500 3250
Wire Wire Line
	7350 3450 7400 3450
Wire Wire Line
	8000 5100 8000 2900
Wire Wire Line
	8000 2900 7700 2900
Wire Wire Line
	7350 4200 7400 4200
Wire Wire Line
	7700 3650 8000 3650
Connection ~ 8000 3650
Wire Wire Line
	7700 4400 7700 4500
Wire Wire Line
	7700 4500 8000 4500
Connection ~ 8000 4500
Wire Wire Line
	5300 2150 5300 1700
Wire Wire Line
	5300 1700 9600 1700
Wire Wire Line
	8050 2300 7700 2300
Wire Wire Line
	7700 2300 7700 2500
Wire Wire Line
	8050 3050 7700 3050
Wire Wire Line
	7700 3050 7700 3250
Wire Wire Line
	8050 3800 7700 3800
Wire Wire Line
	7700 3800 7700 4000
Wire Wire Line
	4150 1850 8450 1850
Wire Wire Line
	8450 1850 8450 3800
Wire Wire Line
	8450 3800 8350 3800
Connection ~ 4150 1950
Wire Wire Line
	8350 3050 8450 3050
Connection ~ 8450 3050
Wire Wire Line
	8350 2300 8450 2300
Connection ~ 8450 2300
Wire Wire Line
	6000 3150 6950 3150
Wire Wire Line
	6950 3150 6950 2700
Wire Wire Line
	6950 2700 7050 2700
Wire Wire Line
	6000 3250 6950 3250
Wire Wire Line
	6950 3250 6950 3450
Wire Wire Line
	6950 3450 7050 3450
Wire Wire Line
	6000 3350 6900 3350
Wire Wire Line
	6900 3350 6900 4200
Wire Wire Line
	6900 4200 7050 4200
Wire Wire Line
	7700 3950 8550 3950
Wire Wire Line
	8550 3950 8550 2500
Wire Wire Line
	8550 2500 9600 2500
Connection ~ 7700 3950
Wire Wire Line
	7700 3200 8650 3200
Wire Wire Line
	8650 3200 8650 2600
Wire Wire Line
	8650 2600 9600 2600
Connection ~ 7700 3200
Wire Wire Line
	7700 2450 8400 2450
Wire Wire Line
	8400 2450 8400 2700
Wire Wire Line
	8400 2700 9600 2700
Connection ~ 7700 2450
Wire Wire Line
	9600 1800 9500 1800
Wire Wire Line
	9500 1800 9500 1700
Connection ~ 9500 1700
Wire Wire Line
	9500 2100 9500 5250
Wire Wire Line
	9500 2100 9600 2100
Connection ~ 5300 5250
Wire Wire Line
	9600 2200 9500 2200
Connection ~ 9500 2200
Wire Wire Line
	9600 2300 9500 2300
Connection ~ 9500 2300
Wire Wire Line
	9600 2400 9500 2400
Connection ~ 9500 2400
Wire Wire Line
	6000 3700 6800 3700
Wire Wire Line
	6800 3700 6800 4650
Wire Wire Line
	6800 4650 9300 4650
Wire Wire Line
	9300 4650 9300 2800
Wire Wire Line
	9300 2800 9600 2800
Wire Wire Line
	6000 3600 6700 3600
Wire Wire Line
	6700 3600 6700 4750
Wire Wire Line
	6700 4750 9400 4750
Wire Wire Line
	9400 4750 9400 2900
Wire Wire Line
	9400 2900 9600 2900
Wire Wire Line
	6000 3050 6900 3050
Wire Wire Line
	6900 3050 6900 2100
Wire Wire Line
	6900 2100 8750 2100
Wire Wire Line
	8750 2100 8750 3100
Wire Wire Line
	8750 3100 9600 3100
Wire Wire Line
	6000 2950 6800 2950
Wire Wire Line
	6800 2950 6800 2000
Wire Wire Line
	6800 2000 8850 2000
Wire Wire Line
	8850 2000 8850 3000
Wire Wire Line
	8850 3000 9600 3000
Wire Wire Line
	6000 3800 6600 3800
Wire Wire Line
	6600 3800 6600 4850
Wire Wire Line
	6600 4850 9200 4850
Wire Wire Line
	9200 4850 9200 2000
Wire Wire Line
	9200 2000 9600 2000
Wire Wire Line
	6000 3900 6500 3900
Wire Wire Line
	6500 3900 6500 4950
Wire Wire Line
	6500 4950 9100 4950
Wire Wire Line
	9100 4950 9100 1900
Wire Wire Line
	9100 1900 9600 1900
$Comp
L Q_NPN_EBC Q1
U 1 1 589113CE
P 3550 3650
F 0 "Q1" H 3500 3900 50  0000 R CNN
F 1 "Q_NPN" H 3500 3800 50  0000 R CNN
F 2 "sap-pcb:TRANSISTOR" H 3750 3750 50  0001 C CNN
F 3 "" H 3550 3650 50  0000 C CNN
	1    3550 3650
	1    0    0    -1  
$EndComp
$Comp
L D D1
U 1 1 589114DB
P 3650 3000
F 0 "D1" H 3650 2900 50  0000 C CNN
F 1 "D" H 3650 2900 50  0001 C CNN
F 2 "Diodes_ThroughHole:D_A-405_P10.16mm_Horizontal" H 3650 3000 50  0001 C CNN
F 3 "" H 3650 3000 50  0000 C CNN
	1    3650 3000
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 58911A69
P 7200 2700
F 0 "R2" V 7280 2700 50  0000 C CNN
F 1 "1k" V 7200 2700 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7130 2700 50  0001 C CNN
F 3 "" H 7200 2700 50  0000 C CNN
	1    7200 2700
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 58911B2B
P 7200 3450
F 0 "R3" V 7280 3450 50  0000 C CNN
F 1 "1k" V 7200 3450 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7130 3450 50  0001 C CNN
F 3 "" H 7200 3450 50  0000 C CNN
	1    7200 3450
	0    1    1    0   
$EndComp
$Comp
L R R4
U 1 1 58911B89
P 7200 4200
F 0 "R4" V 7280 4200 50  0000 C CNN
F 1 "1k" V 7200 4200 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7130 4200 50  0001 C CNN
F 3 "" H 7200 4200 50  0000 C CNN
	1    7200 4200
	0    1    1    0   
$EndComp
$Comp
L Q_NPN_EBC Q2
U 1 1 58912673
P 7600 2700
F 0 "Q2" H 7550 2950 50  0000 R CNN
F 1 "Q_NPN" H 7550 2850 50  0000 R CNN
F 2 "sap-pcb:TRANSISTOR" H 7800 2800 50  0001 C CNN
F 3 "" H 7600 2700 50  0000 C CNN
	1    7600 2700
	1    0    0    -1  
$EndComp
$Comp
L Q_NPN_EBC Q3
U 1 1 5891270E
P 7600 3450
F 0 "Q3" H 7550 3700 50  0000 R CNN
F 1 "Q_NPN" H 7550 3600 50  0000 R CNN
F 2 "sap-pcb:TRANSISTOR" H 7800 3550 50  0001 C CNN
F 3 "" H 7600 3450 50  0000 C CNN
	1    7600 3450
	1    0    0    -1  
$EndComp
$Comp
L Q_NPN_EBC Q4
U 1 1 589127B6
P 7600 4200
F 0 "Q4" H 7550 4450 50  0000 R CNN
F 1 "Q_NPN" H 7550 4350 50  0000 R CNN
F 2 "sap-pcb:TRANSISTOR" H 7800 4300 50  0001 C CNN
F 3 "" H 7600 4200 50  0000 C CNN
	1    7600 4200
	1    0    0    -1  
$EndComp
NoConn ~ 4600 2900
NoConn ~ 4600 3100
NoConn ~ 4600 3200
NoConn ~ 4600 3300
NoConn ~ 4600 3400
NoConn ~ 4600 3500
NoConn ~ 4600 3700
NoConn ~ 4600 3800
NoConn ~ 4600 3600
NoConn ~ 4600 4600
NoConn ~ 4600 4500
NoConn ~ 6000 4000
NoConn ~ 6000 4100
NoConn ~ 6000 2650
NoConn ~ 6000 2750
NoConn ~ 5450 2150
$EndSCHEMATC
