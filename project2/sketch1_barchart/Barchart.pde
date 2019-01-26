

class Barchart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column/bar titles
  int rows, displayCol;
  float rowMin, rowMax;

  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    rows = data.getRowCount();
    data.print();
    println("frame(w, h, u0, v0)" + w +", " + h + ", " + u0 + ", " + v0);
    
    displayCol = 1;
    
    ArrayList<Float> barData = new ArrayList<Float>();
    float[] barDataArray = data.getFloatColumn(displayCol);
    
    //convert to arraylist to get max
    
    for ( int i = 0; i< barDataArray.length; i++){
      //
      
      barData.add(barDataArray[i]);
      
    }
    
    //start at 0
    rowMin = 0;
    rowMax = Collections.max(barData);
    rowMax = 9;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  
  
  void draw() {  
    
    //width of each bar - use window width
    float barWidth = width / rows;
    //data column to use
    
    
    for (int i = 0; i < data.getRowCount(); i++){
      
      
      
      
      
      //map: value, current_start, current_end, target_start, target_end
      
      float adjustedHeight = map( data.getFloat(i, displayCol) , rowMin, rowMax, 0, height);
      
      //x, y, (top left) x, y (bottom right)
      
      
      
      rect(0 + (barWidth * i), height - adjustedHeight, barWidth, height);
      fill(100);
      stroke(0);
      
      println("debug: " + "data val: " + data.getFloat(i, 1) + " adjH: " + adjustedHeight + " i: " + i);
      println("displayCol: " + displayCol);
      
    }
    
    //convert max and min from data to fit in window
   
  
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
