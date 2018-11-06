import processing.video.*;

String movieFilename = "aliens-01-720p.mp4";
String chromakeyDataFile = "jsonData.json";

String backgroundMovieFilename = "motocross-720p.mp4";

float Colour_Dis = 0.0;
int synSize=500;
int synX=550, synY=200;
Boolean blur = false;

Movie vfx, bgReel;
Boolean playing = true;
PImage backgroundImage;
color [] keyColours;

boolean colourCorrecting = false;
int currentReference = -1;

PImage target, bgref;
PImage reference;


void setup() {
  //frameRate(2);

  size(1280, 720);

  loadChromaData(chromakeyDataFile);

  vfx = new Movie(this, movieFilename);
  vfx.loop();

  bgReel = new Movie(this, backgroundMovieFilename);
  bgReel.loop();


}


void draw() {
  if (frameCount%3==0) {
    if (bgReel.available() && vfx.available()) {
      bgReel.read();
      vfx.read();
      image(bgReel, 0, 0);
      //background reference--------------


      bgref = bgReel.get(synX,synY,synSize,synSize);
      
      reference = bgref;
      PImage keyedFrame = chromakey(vfx, keyColours);
      keyedFrame.resize(synSize, synSize);
      if (blur) {
        keyedFrame.filter(BLUR, 1);
      }
      
      if (colourCorrecting) {
      applyScalingsFromTo(reference, keyedFrame);
      }
      image(keyedFrame, synX, synY);

      //theReference.resize(500, 30);
      //image(theReference, width/2-250, height-40);
      println("The video files are availible");
      println("The syn position X: "+ synX);
      println("The syn position Y: "+ synY);
    } else {
      println("The video files are unavailible");
    }

    textSize(40);
    fill(0, 102, 153);
    text(int(frameRate/3), width-55, 40);

    println("the color distance is "+Colour_Dis);
  }





  textSize(20);
  fill(0, 102, 153);
  //text("Press 'Shift' and press the mouse to move the synthetic content", 20, height-50);
  text("Press 'b' to blur, press SPACE to pause", 20, height-80);
  text("Press 'w' or 's' to increase or decrease the color distance", 20, height-50);

}