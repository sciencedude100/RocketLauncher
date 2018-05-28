/* Class: Button
   Author: John Harlan
   Webpage: http://sparkyjohn.tech
*/

import java.lang.Runnable;

class Button{
  PVector pos, size;
  PImage texture;
  
  final Runnable callback;
  
  Button(PVector p, PVector s, PImage t, Runnable CallBack){
    this.pos = p.copy();
    this.size = s.copy();
    this.texture = t;
    this.callback = CallBack;
  }
  
  boolean pressed(float scrolled){
    float x = mouseX - width/10.0;
    float y = mouseY - height/10.0 - scrolled;
    if(x > pos.x && x < pos.x + size.x && y > pos.y && y < pos.y + size.y){
      callback.run();
      return true;
    }
    return false;
  }
  
  void draw(PGraphics pg13){
    pg13.pushStyle();
    pg13.imageMode(CORNER);
    pg13.image(texture, pos.x, pos.y, size.x, size.y);
    pg13.popStyle();
  }
}
