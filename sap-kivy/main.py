import kivy
kivy.require('1.9.1') # replace with your current kivy version !

from kivy.config import Config
Config.set('kivy', 'keyboard_mode', 'systemanddock')
Config.set('graphics', 'maxfps', '100')

from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.tabbedpanel import TabbedPanel
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.popup import Popup
from kivy.clock import Clock
from kivy.properties import StringProperty, NumericProperty, ObjectProperty
from kivy.config import Config
from math import sin
#from kivy.garden.graph import Graph, MeshLinePlot
from kivy.core.window import Window

Window.size = (800,480)

import json
import os
BASE = "/sys/class/backlight/rpi_backlight/"

import serial
import labelStatus, flowCluster
import time

debug_mode = 0

class MainScreen(FloatLayout):
    settings_file = 'settings.json'
    sap_cnts_per_gal = 2566
    water_cnts_per_gal = 2566
    arduino = ObjectProperty(None)
    sap_cal_input = ObjectProperty(None)
    water_cal_input = ObjectProperty(None)
    hp_pump_on_delay_input = ObjectProperty(None)
    min_flow_input = ObjectProperty(None)
    level_sw_mode_switch = ObjectProperty(None)
    screen_brightness_slider = ObjectProperty(None)
    sump_rly = StringProperty(None)
    low_flow = StringProperty(None)
    low_level = StringProperty(None)

    def __init__(self, **kwargs):
        super(MainScreen, self).__init__(**kwargs)
        with open(self.settings_file, 'r') as file:
            data = json.load(file)
            self.sap_cal_input.text = str(data['settings']['sap_cal_gallons'])
            self.water_cal_input.text = str(data['settings']['water_cal_gallons'])
            self.hp_pump_on_delay_input.text = str(data['settings']['hp_pump_on_delay'])
            self.min_flow_input.text = str(data['settings']['minimum_flow'])
            self.level_sw_mode_switch.active = data['settings']['level_sw_mode']
            self.screen_brightness_slider.value = data['settings']['screen_brightness']
            self.sap_cnts_per_gal = data['settings']['sap_cnts_per_gal']
            self.water_cnts_per_gal = data['settings']['water_cnts_per_gal']
        self.brightness()
        self.send_settings()

    def save_settings(self):
        data = {}
        config = {}
        config['sap_cal_gallons'] = int(self.sap_cal_input.text)
        config['water_cal_gallons'] = int(self.water_cal_input.text)
        config['hp_pump_on_delay'] = int(self.hp_pump_on_delay_input.text)
        config['minimum_flow'] = int(self.min_flow_input.text)
        config['level_sw_mode'] = self.level_sw_mode_switch.active
        config['screen_brightness'] = int(self.screen_brightness_slider.value)
        config['sap_cnts_per_gal'] = float("{:.2f}".format(self.sap_cnts_per_gal))
        config['water_cnts_per_gal'] = float("{:.2f}".format(self.water_cnts_per_gal))
        data['settings'] = config
        with open(self.settings_file, 'w') as file:
            json.dump(data, file, sort_keys=True, indent=4)
        self.send_settings()

    def send_settings(self):
        #self.arduino.set('flow_config/sap_cnts_per_gal/' + "{:.2f}".format(self.sap_cnts_per_gal) + '/' + "{:.2f}".format(self.water_cnts_per_gal) + '/') #had to put here, because it didn't make it to arduino when at the end of this function
        level_sw_int = '0'
        if self.level_sw_mode_switch.active:
            level_sw_int = '1'
        self.arduino.set('app_config/level_sw_mode/' + str(level_sw_int) + '/')
        self.arduino.set('app_config/min_flow/' + str(int(self.min_flow_input.text)) + '/')
        self.arduino.set('app_config/hp_pump_on_delay/' + str(int(self.hp_pump_on_delay_input.text)) + '/')
        self.arduino.set('flow_config/sap_cnts_per_gal/' + "{:.2f}".format(self.sap_cnts_per_gal) + '/')
        self.arduino.set('flow_config/water_cnts_per_gal/' + "{:.2f}".format(self.water_cnts_per_gal) + '/')

    def reset_flows(self):
        self.arduino.set('flow_config/reset_sap/0/')
        self.arduino.set('flow_config/reset_water/0/')

    def cal_flows(self):
        self.sap_cnts_per_gal = float(self.arduino.sap_count) / float(self.sap_cal_input.text)
        self.water_cnts_per_gal = float(self.arduino.water_count) / float(self.water_cal_input.text)
        self.save_settings()

    def brightness(self):
        value = int(self.screen_brightness_slider.value)
        '''if value > 0 and value < 256:
            _brightness = open(os.path.join(BASE, "brightness"), "w")
            _brightness.write(str(value))
            _brightness.close()
            return
        raise TypeError("Brightness should be between 0 and 255")'''

    def on_sump_rly(self, instance, state):
        if state == '1':
            self.ids.hi_press_button.disabled = False
        else:
            self.ids.hi_press_button.disabled = True

    def on_low_flow(self, instance, state):
        if state == '1':
            self.ids.low_flow_popup.open()

    def on_low_level(self, instance, state):
        if state == '1':
            self.ids.low_level_popup.open()


class MainApp(App):

    def build(self):
        self.arduino = Arduino()
        return MainScreen()

class Arduino(Widget):
    hi_press_rly = StringProperty('0')
    sump_rly = StringProperty('0')
    spare_rly = StringProperty('0')
    estop_mon = StringProperty('0')
    level_sw = StringProperty('0')
    enabled_mon = StringProperty('0')
    sap_flow = StringProperty('0')
    water_flow = StringProperty('0')
    total_flow = StringProperty('0')
    sap_count = StringProperty('0')
    water_count = StringProperty('0')
    sap_gallons = StringProperty('0')
    water_gallons = StringProperty('0')
    total_gallons = StringProperty('0')
    efficiency = StringProperty('0')
    efficiency_total = StringProperty('0')
    low_flow_flag = StringProperty('0')
    low_level_flag = StringProperty('0')
    system_status = StringProperty('0')

    def __init__(self, **kwargs):
        super(Arduino, self).__init__(**kwargs)
        self.array_size = 20
        self.data_array = ['0'] * self.array_size
        Clock.schedule_interval(self.update_data, 0)

    def update_data(self, dt):
        if debug_mode == 0:
            try:
                self.data_array = ser.readline().rstrip().split(',')
                #print(self.data_array)
            except:
                print('Serial Read Failure')
                exit()
        else:
            self.data_array = ['0'] * self.array_size
        if len(self.data_array) == self.array_size:
            self.hi_press_rly = self.data_array[0]
            self.sump_rly = self.data_array[1]
            self.spare_rly = self.data_array[2]
            self.estop_mon = self.data_array[3]
            self.level_sw = self.data_array[4]
            self.enabled_mon = self.data_array[5]
            self.sap_flow = self.data_array[6]
            self.water_flow = self.data_array[7]
            self.total_flow = self.data_array[8]
            self.sap_count = self.data_array[9]
            self.water_count = self.data_array[10]
            self.sap_gallons = self.data_array[11]
            self.water_gallons = self.data_array[12]
            self.total_gallons = self.data_array[13]
            self.efficiency = self.data_array[14]
            self.efficiency_total = self.data_array[15]
            self.low_flow_flag = self.data_array[16]
            self.low_level_flag = self.data_array[17]
            self.system_status = self.data_array[18]
            '''self.efficiency = '99'
            self.sap_flow = '65.3'
            self.sap_gallons = '124.9'
            self.water_flow = '81.0'
            self.water_gallons = '95.2'
            self.total_flow = '130.5'
            self.total_gallons = '200.6'
            '''

    def get(self, index):
        return self.data_array[index]

    def set(self, command):
        ser.write(command)
        time.sleep(.1)

    def set_state(self, command, state):
        if state == "down":
            int_state = '1/'
        else:
            int_state = '0/'
        ser.write(command + int_state)

if __name__ == '__main__':

    if debug_mode == 0:
        try:
            ser = serial.Serial('/dev/ttyUSB0', 9600)
        except:
            print "Failed to connect"
            exit()

    MainApp().run()

    ser.close()
    print('closed')
