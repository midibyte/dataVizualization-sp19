public class Bar{
  float x, y, w, h;
  color barColor;
  int clickBuffer = 2;
  float origX, origY;
  
  Bar(float _x, float _y, float _w, float _h){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
  }
  Bar(float _x, float _y, float _w, float _h, color _barColor){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    barColor = _barColor;
    
  }
  
  Bar(float _x, float _y, float _w, float _h, float _origX, float _origY){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    origX = _origX;
    origY = _origY;
    
  }
  
  void printBar(){
    println(String.format("bar x, y, w, h: %f, %f, %f, %f" , x, y, w, h) ); 
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
    fill(0);
    stroke(0);
    rect(x, y, w, h);
    
    pushMatrix();
    translate(x + w/2, y + h/2);
    rotate(PI/2);
    textSize(w - (w/5));
    String temp = String.format("%.0f", origY);
    
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
