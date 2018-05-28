/* Miscellanious Functions
   Author: John Harlan
   Webpage: http://sparkyjohn.tech
*/

//Button( POSITION, SIZE, IMAGE, CALLBACK)
//generateButtonBase( SIZE, MARGINS, LABEL)

//----------HELPER FUNCTIONS FOR initializeButtons()----------
final int DFLT_BTN_COLOR = 0xFF323264;
final int DFLT_TXT_COLOR = 0xFFBBBBBB;

//The margins parameter is a string representation of a nibble for where the edges of the window are:         
//If the top and left sides of the button were against window edges, it would be 0b1001. The order (msb->lsb) is clockwise, starting at the top.
PGraphics generateButtonBase(PVector size, String marginString, String label, PFont font) {
  return generateButtonBase(size, marginString, label, DFLT_BTN_COLOR, DFLT_TXT_COLOR, font);
}

PGraphics generateButtonBase(PVector size, String marginString, String label, int fillColor, int textColor, PFont font) {
  int margins = unbinary(marginString);
  int tMargin, rMargin, bMargin, lMargin;
  tMargin = rMargin = bMargin = lMargin = 3;
  lMargin += 3* (margins&0x1);
  tMargin += 3*((margins&0x8)>>3);
  rMargin += 3*((margins&0x4)>>2) + lMargin;
  bMargin += 3*((margins&0x2)>>1) + tMargin;

  int textSize = 1;
  PGraphics t = createGraphics((int)size.x, (int)size.y);
  
  t.smooth(3);
  t.beginDraw();
  t.noStroke();
  t.fill(fillColor);
  t.rectMode(CORNER);
  t.rect(lMargin, tMargin, size.x-rMargin, size.y-bMargin, 3);

  t.fill(textColor);
  t.textAlign(CENTER, CENTER);
  t.textFont(font);
  t.textSize(textSize);
  
  while (t.textWidth(label) < size.x * .75 && textSize <= 64) {
    t.textSize(textSize);
    textSize ++;
  }
  textSize--;
  
  int lines = 1;
  for(int i = 0; i < label.length(); i ++){
    if(label.charAt(i) == '\n'){
      lines ++;
    }
  }
  float textHeight = (t.textAscent() + t.textDescent()) * lines;
  
  while(textHeight > size.y * .75 && textSize > 0){
    t.textSize(textSize);
    textSize --;
    textHeight = (t.textAscent() + t.textAscent()) * lines;
  }

  t.text(label, lMargin, tMargin, size.x-rMargin, size.y-bMargin);
  t.endDraw();

  return t;
}
//------------------------------------------------------------ Good comment, I approve

void drawLabels(){
  fill(255);
  textSize(35);
  text("Shutdown\nPrinter?", 0, height, width, height / 3 + height);
}
