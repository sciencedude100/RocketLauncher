import java.net.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.io.*;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import javax.swing.*; 

String[] getUnPw(boolean DEBUG){
  String[] result = new String[4];
  String username = JOptionPane.showInputDialog(frame, "Minecraft / Mojang Email", "spideySense@avengers.org");
  String password = "";
  JPasswordField passField = new JPasswordField(24);
  JPanel passPop = new JPanel();
  JLabel passPrompt = new JLabel("Password: ");
  passPop.add(passPrompt);
  passPop.add(passField);
  String[] opt = new String[]{"OK", "Cancel"};
  if (JOptionPane.showOptionDialog(null,passPop,"Password",JOptionPane.NO_OPTION,JOptionPane.PLAIN_MESSAGE,null,opt,opt[1]) == 0){
    char[] passchar = passField.getPassword();
    password += new String(passchar);
    if(DEBUG){
      println("Username: " + username + "   Password: " + new String(passchar));
      println("String Pass: " + password);
    }
  }
  //do something with UN/PW
  result[0] = username;
  result[1] = password;
  String data = "";
  try{
    URL earl = new URL("https://authserver.mojang.com/authenticate");
    HttpsURLConnection c = (HttpsURLConnection)earl.openConnection();
    c.setRequestMethod("POST");
    c.setRequestProperty("Content-Type", "application/json");
    c.setDoInput(true);
    c.setDoOutput(true);
    OutputStream os = c.getOutputStream();
    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"));
    String payload = "{\n\"agent\":{\n\"name\":\"Minecraft\",\n\"version\":1\n},\n\"username\":\"" + username + "\",\n\"password\":\"" + password + "\",\n\"clientToken\":\"" + "cc2d59fb-f87a-49c2-b482-36c24b208e8f" + "\",\n\"requestUser\": true\n}";
    bw.write(payload);
    bw.flush();
    bw.close();
    os.close();
    c.connect();
    InputStream is = c.getInputStream();
    while (is.available() > 0){
      data += (char)is.read();
    }
  }catch(Exception e){
  }
  if (!data.equals("")){
    JSONObject js = parseJSONObject(data);
    result[2] = js.getJSONObject("user").getString("id");
    result[3] = js.getJSONObject("selectedProfile").getString("name");
  }else{
    result[2] = "";
    result[3] = "";
  }
  return result;
}

void drawPlay(){
  PGraphics disp = createGraphics(width-(width/5), height-(height/10));
  disp.beginDraw();
  disp.translate(0, page_position[0]);
  drawPacks(disp);
  disp.endDraw();
  image(disp, width/10, height/10);
}

void drawInstances(){
  PGraphics disp = createGraphics(width-(width/5), height-(height/10));
  disp.beginDraw();
  disp.translate(0, page_position[1]);
  disp.rect(10, 10, 50, 20);
  disp.endDraw();
  image(disp, width/10, height/10);
}

void drawLog(){
  PGraphics disp = createGraphics(width-(width/5), height-(height/10));
  disp.beginDraw();
  disp.translate(0, page_position[2]);
  disp.rect(10, 10, 50, 20);
  disp.endDraw();
  image(disp, width/10, height/10);
}

void drawSettings(){
  PGraphics disp = createGraphics(width-(width/5), height-(height/10));
  disp.beginDraw();
  disp.translate(0, page_position[3]);
  
  settings_buttons[0].draw(disp);
  
  disp.endDraw();
  image(disp, width/10, height/10);
}

void setupButtons(int page, Button[] b){
  PVector[] dim = new PVector[2];
  dim[0] = new PVector(0,0);
  dim[1] = new PVector(70,30);
  switch(page){
    case 1:
      break;
    case 2:
      break;
    case 3:
      b[0] = new Button(dim[0], dim[1], generateButtonBase(dim[1], "0000", "LOGIN", ui_font), new Runnable(){
        public void run(){
          String[] userInfo = getUnPw(DEBUG);
          println(userInfo[2]);
        }
      });
      break;
    default:
      break;  
}
}

void drawPacks(PGraphics d){
  d.fill(158, 158, 158);
  //d.rect(5, 5*pack, 
}
