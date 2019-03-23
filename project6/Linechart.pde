

class Linechart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column to display along y axis
  String xCol;        //column to use on the x axis
  int rows, displayCol;
  float dataMin, dataMax;
  ArrayList<Point> points = null;
  List<String> names;
  float min_x, min_y, max_x, max_y;

  String useX, useY;
  float[] dataX, dataY;

  boolean colors = false;
  ArrayList<String> uniqueNamesList = null;
  ArrayList<Integer> rgb = null;

  ArrayList<Point> sortedPoints = null;

  Linechart( Table _data, String _useColumn, String _xCol ) {
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    xCol = _xCol;
    useX = xCol;
    useY = _useColumn;
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
    dataMin = Collections.min(barData);
    dataMax = Collections.max(barData);

  }
  
  ArrayList<Point> getPointList() { return points; }
  
  void setColumn( String _useColumn ){
    useColumn = _useColumn;
  }
  
  ArrayList<String> getUniqueNamesList(){
   return uniqueNamesList; 
  }
  
  ArrayList<Integer> getColorsList(){
   return rgb; 
  }

  void draw() {
    
    //creates points from data
    for (int i = 1; i < points.size(); i++){
      Point p1 = points.get( i - 1);
      Point p2 = points.get( i );
      strokeWeight(1);
      strokeJoin(ROUND);
      strokeCap(ROUND);
      line( p1.x, p1.y, p2.x, p2.y );
      //need this to reset strokeweight for frame outline
      strokeWeight(1);
      
    }
    
    drawPoints();
    
  }
  
  void drawPoints(){
   
    for (int i = 0; i< points.size(); i++){
      
      Point p = points.get(i);
      if (colors == false ) fill(0);
      
      else{
        fill( rgb.get( uniqueNamesList.indexOf( names.get(i) ) ) );
      }
      
      ellipse(p.x, p.y, pointSize, pointSize);
      //reset fill
      noFill();
    }
    
  }
  
  //void setupPointList() {  

  //  points = new ArrayList<Point>();
    
  //  //width of each bar - use window width
  //  float barWidth = w / rows;
  //  //data column to use
    
  //  //first get point coordinates
  //  for (int i = 0; i < data.getRowCount(); i++){

  //    //map: value, current_start, current_end, target_start, target_end
  //    float adjustedHeight = map( data.getFloat( i, displayCol ), dataMin, dataMax, 0, h );

  //    //add point to point list
  //    Point temp = new Point( (barWidth/2) + u0 + ( barWidth * i ), v0 + h - adjustedHeight );
      
  //    temp.setPointSize(pointSize);
  //    temp.setOrigXY( data.getFloat( i, xCol ), data.getFloat( i, displayCol ));
      
  //    points.add( temp );

  //  }
  //}
  void setupPointList() {  

    //get data arrays from table
    dataX = data.getFloatColumn(useX);
    dataY = data.getFloatColumn(useY);
    
    //sort arrays to get min and max
    Arrays.sort(dataX);
    Arrays.sort(dataY);
    
    max_x = dataX[dataX.length - 1];
    max_y = dataY[dataY.length - 1];
    min_x = dataX[0];
    min_y = dataY[0];
    
    //min_x = min_y = 0;
    
    points = new ArrayList<Point>();
    
    //map x and y data to frame size
    //x: u0, u0+w
    //y: v0, v0+h
    
    for (int i = 0; i < dataX.length; i++){
     

      float newX = map(data.getFloatColumn(useX)[i], min_x, max_x, u0, u0 + w);
      //reverse target to get correct position
      float newY = map(data.getFloatColumn(useY)[i], min_y, max_y, v0 + h, v0);
      //float newY = map(dataY[i], min_y, max_y, v0, v0 +h);

      //println(newX + " " + newY);
      Point temp = new Point(newX, newY);
      temp.setOrigXY(data.getFloatColumn(useX)[i], data.getFloatColumn(useY)[i]);
      temp.setPointSize(pointSize);
      points.add( temp );
      
    }
    
    //sort point list by x to get correct placement on x axis
    sortedPoints = new ArrayList<Point>(points);
    Collections.sort(sortedPoints, new PointCompare());
    points = sortedPoints;
  }
  
  void labelsBelowPoints(){
    //points are locations to draw labels
    //get text and color info from use column
    
    for(int i = 0; i < points.size(); i++){

      String temp = String.format( "%.2f", data.getFloatColumn(useColumn)[i] );
      
      textAlign(RIGHT, TOP);
      textSize( pointLabelFontSize );
      fill(0);
      text( temp, points.get(i).x + pointLabelFontSize, points.get(i).y + pointLabelFontSize);
    }
   

  }
  
  void setColorsFromNames(String colorCol){
    
    Set<String> uniqueNames;
    ArrayList<Float> r, g, b;
    //only set once to prevent changing every time draw is called
    if (colors == true) return;
    colors = true;
    //get name strings, then get unique only, then convert to list to use later with index
    names = Arrays.asList(data.getStringColumn(colorCol));
    uniqueNames = new HashSet<String>(names);
    uniqueNamesList = new ArrayList<String>();
    uniqueNamesList.addAll(uniqueNames);

    rgb = new ArrayList<Integer>();
    
    //set colors for each name
    for (int i = 0; i < uniqueNames.size(); i++) {
     
      //add a random color for each unique name
      rgb.add( color( random(255), random(255), random(255) ) );
      
    }   
    
    
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
