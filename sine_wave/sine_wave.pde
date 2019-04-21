import controlP5.*;
import beads.*;
import java.util.Arrays;

AudioContext ac;

ControlP5 cp5;

int sineCount = 10;
float baseFrequency = 440.0;

Glide[] sineFrequency = new Glide[sineCount];
Gain[] sineGain = new Gain[sineCount];

Gain gain;
Glide frequencyGlide;

WavePlayer[] sineTone = new WavePlayer[sineCount];

boolean buttonPressed;
WavePlayer wp;

void setup() {
  size(250,150);
  ac = new AudioContext();
  cp5 = new ControlP5(this);
  
  buttonPressed = false;
  
  frequencyGlide = new Glide(ac, 440, 200);
  gain = new Gain(ac, 2, 1);
  
  ac.out.addInput(gain);
  
  wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
  ac.out.addInput(wp);
  wp.pause(true);
    
  ac.start();
  
  cp5.addButton("Sine")
    .setCaptionLabel("Sine Wave")
    .setPosition(0,60)
    .setSize(100,30);
    
  cp5.addSlider("frequencySlider")
    .setLabel("Change Sine Wave Frequency")
    .setPosition(0,20)
    .setWidth(100)
    .setHeight(25)
    .setRange(100,780)
    .setValue(440);
}

void draw() {
  background(0);
}

public void Sine() {
  buttonPressed =! buttonPressed;
  if (buttonPressed) {
    wp.pause(false);
  } else {
    wp.pause(true);
  }
}

public void frequencySlider (float newFrequency) {
  frequencyGlide.setValue(newFrequency);
}
