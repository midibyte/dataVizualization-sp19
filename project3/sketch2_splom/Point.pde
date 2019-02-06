public class Point {
  
  float x, y, datax, datay;
  int ptColor = -1;

  Point(float _x, float _y ){
    x = _x;
    y = _y;
  }

  Point(float _x, float _y, float _datax, float _datay ){
    x = _x;
    y = _y;
    datax = _datax;
    datay = _datay;
  }
  
  void setColor(int _color){
    ptColor = _color; 
  }
  
  void print(){
    
    println( "x: " + x + " y: " + y );
    
  }
  
}
