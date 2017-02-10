import kivy
kivy.require('1.9.1') # replace with your current kivy version !

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
Config.set('graphics', 'maxfps', '10')

import serial
import labelStatus, flowCluster

debug_mode = 1

class MainScreen(FloatLayout):
    pass

class MainApp(App):
    passcode = '1234'
    passcode_try = ''
    logged_in = NumericProperty(0)

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
    low_flow_flag = StringProperty('0')
    low_level_flag = StringProperty('0')
    system_status = StringProperty('0')

    def __init__(self, **kwargs):
        super(Arduino, self).__init__(**kwargs)
        self.array_size = 19
        self.data_array = ['0'] * self.array_size
        Clock.schedule_interval(self.update_data, 0)

    def update_data(self, dt):
        if debug_mode == 0:
            try:
                self.data_array = ser.readline().rstrip().split(',')
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
            self.low_flow_flag = self.data_array[15]
            self.low_level_flag = self.data_array[16]
            self.system_status = self.data_array[17]
            self.efficiency = '99'
            self.sap_flow = '65.3'
            self.sap_gallons = '124.9'
            self.water_flow = '81.0'
            self.water_gallons = '95.2'
            self.total_flow = '130.5'
            self.total_gallons = '200.6'

    def get(self, index):
        return self.data_array[index]

    def set(self, command):
        ser.write(command)

if __name__ == '__main__':

    if debug_mode == 0:
        try:
            ser = serial.Serial('/dev/ttyUSB0', 115200)
        except:
            print "Failed to connect"
            exit()

    MainApp().run()

    ser.close()
    print('closed')
