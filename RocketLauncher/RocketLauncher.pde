import java.net.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.io.*;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import javax.swing.*;
import static javax.swing.JOptionPane.*;

boolean DEBUG = true;
PImage wall;
PFont ui_font;
Button settings_buttons[];
float page_position[]; // positive is downward
int menu = 0;
/* Menu Screens:
   0 - Play
   1 - Instances
   2 - Log
   3 - Settings
*/

void setup(){
  size(800, 400);
  surface.setResizable(true);
  wall = loadImage("wallpaper.png");
  ui_font = createFont("RobotoCondensed-Regular.ttf", 32);
  page_position = new float[4];
  settings_buttons = new Button[1];
  setupButtons(3, settings_buttons);
  if (DEBUG){
    showMessageDialog(null, "You are currently in DEBUG mode.", "DEBUG Enabled", INFORMATION_MESSAGE);
  }
}

void draw(){
  background(0);
  image(wall, 0, 0, width, height);
  drawUI(width, height, menu);
}

void mouseWheel(MouseEvent e){
  //ToDo: manage scrolling here
  if (page_position[menu] > 0.0){
    page_position[menu] = 0.0;
  }else{
    page_position[menu] -= e.getCount()*3;
  }
}

void mouseClicked(){
  int left_border = width/10;
  int menu_height = height/10;
  int menu_width = (width-(width/10)-(width/10))/4;
  if (mouseX >= width/10 && mouseX <= width-(width/10)){
    //if mouse is withing UI
    if (mouseY > 0 && mouseY <= menu_height){
      //if mouse is within main menu bar
      if (mouseX < left_border+(menu_width*1)){
        menu = 0;
      }else if (mouseX < left_border+(menu_width*2)){
        menu = 1;
      }else if (mouseX < left_border+(menu_width*3)){
        menu = 2;
      }else if (mouseX < left_border+(menu_width*4)){
        menu = 3;
      }
    }else{
      handleScreen(mouseX, mouseY, menu);
    }
  }else if (DEBUG && mouseX > (width-(width/10)) && mouseY < menu_height){
    menu++;
  }else if (DEBUG && mouseX < (width/10) && mouseY < menu_height){
    menu--;
  }
}

void handleScreen(int x, int y, int m){
  switch(m){
    case 0:  // Play screen
      //TODO: create scrollable area with each installed pack
      break;
    case 1:  // Instances screen
      //TODO: download / install packs from Vinella Minecraft
      break;
    case 2:  // Log screen
      //TODO: dump java ouput log here
      break;
    case 3:  // Settings screen
      //TODO: Edit settings UI (possibly need submenu or scrolling from "Play"
      for(int i=0; i<settings_buttons.length; i++){
        settings_buttons[i].pressed(page_position[3]);
      }  
      break;
    default:  // 
      showMessageDialog(null, "menu number " + m + " invalid", "Handle Alert", ERROR_MESSAGE);
      break;
  }
}

void drawUI(int w, int h, int sel){
  int left_border = w/10;
  int menu_height = h/10;
  int ui_label_text_height = (menu_height/2)+10;
  int main_rect_len = w-left_border-left_border;
  fill(200, 200, 200, 200);
  noStroke();
  rect(left_border, 0, main_rect_len, h);
  rect(left_border+(sel*(main_rect_len/4)), 0, (main_rect_len/4), menu_height);
  rect(left_border, menu_height, main_rect_len, h-menu_height);
  textFont(ui_font);
  if(sel == 0){
    fill(0, 0, 150);
  }else{
    fill(0, 0, 0);
  }
  text("Play", left_border+(main_rect_len/8)-32, ui_label_text_height);
  if(sel == 1){
    fill(0, 0, 150);
  }else{
    fill(0, 0, 0);
  }
  text("Instances", left_border+((3*main_rect_len)/8)-60, ui_label_text_height);
  if(sel == 2){
    fill(0, 0, 150);
  }else{
    fill(0, 0, 0);
  }
  text("Log", left_border+((5*main_rect_len)/8)-20, ui_label_text_height);
  if(sel == 3){
    fill(0, 0, 150);
  }else{
    fill(0, 0, 0);
  }
  text("Settings", left_border+((7*main_rect_len)/8)-55, ui_label_text_height);
  switch(sel){
    case 0:  // Play screen
      //TODO: create scrollable area with each installed pack
      drawPlay();
      break;
    case 1:  // Instances screen
      //TODO: download / install packs from Vinella Minecraft
      drawInstances();
      break;
    case 2:  // Log screen
      //TODO: dump java ouput log here
      drawLog();
      break;
    case 3:  // Settings screen
      //TODO: Edit settings UI (possibly need submenu or scrolling from "Play"
      drawSettings();
      break;
    default:
      break;
  }
}
