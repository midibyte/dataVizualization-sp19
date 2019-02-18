public class Bar{
  float x, y, w, h;
  color barColor;
  int clickBuffer = 2;
  float origVal;
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
  
  Bar(float _x, float _y, float _w, float _h, float _origVal){
   
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    origVal = _origVal;
    
  }
  
  boolean mouseInside(){
     return (x -clickBuffer < mouseX) && (x +w+clickBuffer)>mouseX && (y -clickBuffer)< mouseY && (y+h+clickBuffer)>mouseY; 
  }
  
  void draw(){
    rectMode(CORNER);
    fill(100);
    stroke(0);
    rect(x, y, w, h);

  }
  
}
