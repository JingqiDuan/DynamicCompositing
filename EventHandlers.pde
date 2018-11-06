void keyPressed() {


  switch (key) {
  case ' ':
    playing = !playing;
    if (playing) {
      vfx.loop();
    } else {
      vfx.pause();
    }
    break;

  case 'b':
    blur = ! blur;
    break;

  case 'w':
    Colour_Dis = Colour_Dis+ 1;
    break;

  case 's':
    Colour_Dis = Colour_Dis- 1;
    break;
    

  }
}

void mousePressed() {
  
  
  colourCorrecting = !colourCorrecting;
  //currentReference = (currentReference + 1 ) % 2;
}