public class Point {
  
  float x, y;
  float pointSize = 0;
  int clickBuffer = 2;
  float origX = 0; 
  float origY = 0;
  Point(float _x, float _y ){
    x = _x;
    y = _y;
  }
  
  void print(){
    
    println( "x: " + x + " y: " + y );
    
  }
  
  float getX() {return x;}
  
  //used to record values for click and displaying popup text
  void setPointSize(float _pointSize) {pointSize = _pointSize;}
  void setOrigXY(float _origX, float _origY) {origX = _origX; origY = _origY;}
  
  boolean mouseInside(){
     return (x -clickBuffer < mouseX) && (x + pointSize +clickBuffer)>mouseX && (y -clickBuffer)< mouseY && (y+ pointSize + clickBuffer)>mouseY; 
  }
  
}
