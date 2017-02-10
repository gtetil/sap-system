from kivy.uix.slider import Slider
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import NumericProperty, StringProperty, ObjectProperty
from kivy.uix.label import Label
from kivy.factory import Factory
from kivy.lang import Builder

Builder.load_string("""
<FlowCluster>:
    orientation: 'vertical'
    flow: self.flow
    gallons: self.gallons

    Label:
        text: 'Sap'
        font_size: '40sp'
        markup: 'True'

    Label:
        text: root.flow + '[size=20]  GPH[/size]'
        font_size: '45sp'
        markup: 'True'

    Label:
        text: root.gallons + '[size=20]  gal[/size]'
        font_size: '30sp'
        markup: 'True'

""")

class FlowCluster(BoxLayout):
    flow = StringProperty('')
    gallons = StringProperty('')

Factory.register('KivyB', module='FlowCluster')