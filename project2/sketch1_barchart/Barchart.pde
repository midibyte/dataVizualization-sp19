

class Barchart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column/bar titles
  int rows, displayCol;
  float dataMin, dataMax;

  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    rows = data.getRowCount();
    data.print();
    
    
    displayCol = 2;
    
    ArrayList<Float> barData = new ArrayList<Float>();
    float[] barDataArray = data.getFloatColumn(displayCol);
    
    //convert to arraylist to get max
    
    for ( int i = 0; i< barDataArray.length; i++){
      //
      
      barData.add(barDataArray[i]);
      
    }
    
    //start at 0
    dataMin = 0;
    dataMax = Collections.max(barData);
    //dataMax = 9;
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  
  
  void draw() {  
    
    //println("frame(w, h, u0, v0)" + w +", " + h + ", " + u0 + ", " + v0);
    
    fill (255, 100, 100, 100);
    stroke(0);
    rectMode(CORNER);
    rect(u0, v0, w, h);
    
    
    //width of each bar - use window width
    float barWidth = w / rows;
    //data column to use
    
    
    for (int i = 0; i < data.getRowCount(); i++){

      //map: value, current_start, current_end, target_start, target_end
      //reverse target start and end
      float adjustedHeight = map( data.getFloat( i, displayCol ), dataMin, dataMax, 0, h );
      
      //x, y, (top left) x, y (bottom right)
      
      
      fill(100);
      stroke(0);
      //rectMode(CORNERS);
      //rect(u0 + (barWidth * i), adjustedHeight, u0 + (barWidth * i) + barWidth, h);
      rect(u0 + (barWidth * i), v0+h - adjustedHeight, barWidth, adjustedHeight);
      
      
      //println("debug: " + "data val: " + data.getFloat(i, 1) + " adjH: " + adjustedHeight + " i: " + i);
      //println("displayCol: " + displayCol);
      
    }
    
    //convert max and min from data to fit in window
   
  
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
