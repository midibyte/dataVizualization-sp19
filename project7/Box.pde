public class Box{
  float x, y, w, h;
  int BoxColor = 0;
  int clickBuffer = 2;
  float origX;
  String strX, strY, strZ;
  String title = "";
  Boolean textonly = false;
  
  void setColor(int _BoxColor){ BoxColor = _BoxColor; }
  void setTitle(String _title) { title = _title; }
  void textOnly() {textonly = true;}
  
  Box(float _x, float _y, float _w, float _h){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
  }
  Box(float _x, float _y, float _w, float _h, color _BoxColor){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    BoxColor = _BoxColor;
    
  }
  
  Box(float _x, float _y, float _w, float _h, float _origX, String _strX, String _strY){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    origX = _origX;
    strX = _strX;
    strY = _strY;
    
  }
  Box(float _x, float _y, float _w, float _h, String _strX, String _strY, String _strZ){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    textonly = true;

    strX = _strX;
    strY = _strY;
    strZ = _strZ;
    
  }
  
  void printBox(){
    //println(String.format("Box x, y, w, h: %f, %f, %f, %f" , x, y, w, h) ); 
  }
  
  boolean mouseInside(){
     return (x -clickBuffer < mouseX) && (x +w+clickBuffer)>mouseX && (y -clickBuffer)< mouseY && (y+h+clickBuffer)>mouseY; 
  }
  
  void setX(float _x) { x = _x; }
  void drawHighlighted(){
    rectMode(CORNER);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(x, y, w, h);
  }
  void draw(){
    rectMode(CORNER);
    if(!textonly){
      if (BoxColor == 0) fill(255, 0, 0, origX * 200);
      else fill(0, 0, 255, origX * 200);
    }
    else fill(0);
    stroke(0);
    rect(x, y, w, h);
    
    pushMatrix();
    translate(x + w/2, y + h/2);
    rotate(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    String temp;
    if (!textonly)  temp = String.format("%s\n%s, %s:\n%.4f", title, strX, strY, origX);
    else temp = String.format("%s, %s:\n%s", strX, strY, strZ);
    
    fill(0);
    text(temp, -1,0);
    text(temp, 1,0);
    text(temp, 0,-1);
    text(temp, 0,1);
    fill(255);
    text(temp, 0,0);
    
    popMatrix();
  }
  
}
