

class Barchart extends Frame {

  Table data;
  String useColumn;

  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  void draw() {  
  
    println("window width: " + width);
  
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
