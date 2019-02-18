

class Linechart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column to display along y axis
  int rows, displayCol;
  float dataMin, dataMax;
  ArrayList<Point> points = null;
  List<String> names;

  boolean colors = false;
  ArrayList<String> uniqueNamesList = null;
  ArrayList<Integer> rgb = null;

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
  
  void setupPointList() {  

    points = new ArrayList<Point>();
    
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

    }
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
