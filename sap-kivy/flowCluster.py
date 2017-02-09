from kivy.uix.slider import Slider
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import NumericProperty, StringProperty, ObjectProperty
from kivy.uix.label import Label
from kivy.factory import Factory
from kivy.lang import Builder

Builder.load_string("""
<FlowCluster>:
    orientation: 'vertical'

    Label:
        text: 'Sap'
        size_hint: 1, 0.2
        font_size: '40sp'

    BoxLayout:
        orientation: 'horizontal'
        size_hint: 1, 0.5

        Label:
            #text: app.arduino.sap_flow
            text: '65.9'
            font_size: '40sp'

        Label:
            text: 'GPH'
            font_size: '20sp'

    BoxLayout:
        orientation: 'horizontal'
        size_hint: 1, 0.3

        Label:
            #text: app.arduino.sap_gallons
            text: '137.5'
            font_size: '20sp'

        Label:
            text: 'gal'
            font_size: '20sp'
""")

class FlowCluster(BoxLayout):
    header = StringProperty('')
    slider_max = NumericProperty(0)
    slider_min = NumericProperty(0)
    slider_inc = NumericProperty(0)
    actual = StringProperty('')
    cmd_type = StringProperty('')
    tank_cmd = StringProperty('')
    button_inc = NumericProperty(0)
    id = ObjectProperty(None)

Factory.register('KivyB', module='FlowCluster')