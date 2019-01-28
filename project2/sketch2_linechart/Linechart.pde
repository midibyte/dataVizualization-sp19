

class Linechart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column to display along y axis
  int rows, displayCol;
  float dataMin, dataMax;
  ArrayList<Point> points = null;

  Linechart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    rows = data.getRowCount();
    data.print();
    displayCol = data.getColumnIndex(useColumn);
    
    ArrayList<Float> barData = new ArrayList<Float>();
    float[] barDataArray = data.getFloatColumn(displayCol);
    
    //convert to arraylist to get max
    
    for ( int i = 0; i< barDataArray.length; i++){

      barData.add(barDataArray[i]);
      
    }
    
    //start at 0
    dataMin = 0;
    dataMax = Collections.max(barData);


    
  }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }

  void draw() {
    
    //creates points from data
    setupPointList();
 
    for (int i = 1; i < points.size(); i++){
      Point p1 = points.get( i - 1);
      Point p2 = points.get( i );
      strokeWeight(4);
      strokeJoin(ROUND);
      strokeCap(ROUND);
      line( p1.x, p1.y, p2.x, p2.y );
      //need this to reset strokeweight for frame outline
      strokeWeight(1);
    }
    
  }
  
  void setupPointList() {  

    points = new ArrayList<Point>();
    
    //String[] party = data.getStringColumn(3);
    
    //width of each bar - use window width
    float barWidth = w / rows;
    //data column to use
    
    //first get point coordinates
    for (int i = 0; i < data.getRowCount(); i++){

      //map: value, current_start, current_end, target_start, target_end
      float adjustedHeight = map( data.getFloat( i, displayCol ), dataMin, dataMax, 0, h );

      //add point to point list
      Point temp = new Point( (barWidth/2) + u0 + ( barWidth * i ), v0 + h - adjustedHeight );
      points.add( temp );
      //temp.print();
      
      //println("debug: " + "data val: " + data.getFloat(i, displayCol) + " adjH: " + adjustedHeight + " u0 " + u0 + " v0 " + v0 + " i: " + i);
      //println("displayCol: " + displayCol);
      
    }

  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
