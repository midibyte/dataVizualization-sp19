

class Barchart extends Frame {

  Table data;        //Table Object
  String useColumn;  //column to display along y axis
  int rows, displayCol;
  float dataMin, dataMax;
  ArrayList<Point> points = null;
  List<String> names;
  Set<String> uniqueNames;
  ArrayList<Float> r, g, b;
  boolean colors = false;
  ArrayList<String> uniqueNamesList = null;
  ArrayList<Integer> rgb = null;
  ArrayList<Bar> bars = null;
  String xCol;
  float barWidth = w / rows;
  
  ArrayList<Bar> sortedBars = null;
  
  Barchart( Table _data, String _useColumn, String _xCol ) {
    xCol = _xCol;
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    rows = data.getRowCount();
    data.print();
    displayCol = data.getColumnIndex(useColumn);  //column number to use for bars
    
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
  
  ArrayList<String> getUniqueNamesList(){
   return uniqueNamesList; 
  }
  
  ArrayList<Integer> getColorsList(){
   return rgb; 
  }
  
  ArrayList<Bar> getBarList() {return bars;}
  
  void labelsBelowPoints(){
   
    //points are locations to draw labels
    //get text and color info from use column
    
    for(int i = 0; i < points.size(); i++){
     
      
      String temp = String.format( "%.2f", data.getFloatColumn(useColumn)[i] );
      
      textAlign(CENTER, TOP);
      textSize( pointLabelFontSize );
      fill(255);
      text( temp, points.get(i).x, points.get(i).y );
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
  
  void setupBars(){
  
    bars = new ArrayList<Bar>();
    
    noFill();
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
      
      color tempColor;
      
      if (colors == true){
         //println(uniqueNamesList);
         int uniqueVal = uniqueNamesList.indexOf(names.get(i));
         //println(uniqueVal);
         
         if (uniqueVal == -1) {
           //use generic color if no match
           fill(100);
           noStroke(); 
         }
         
         //fill with color unique to the name
         fill(r.get(uniqueVal), g.get(uniqueVal), b.get(uniqueVal));
         
         tempColor = color(r.get(uniqueVal), g.get(uniqueVal), b.get(uniqueVal));
         
      }
      else {
        fill(100);
        stroke(0);
      }
      
      bars.add(new Bar( (u0 + (barWidth * i) ), ( v0 + h - adjustedHeight ), barWidth, adjustedHeight, data.getFloat( i, displayCol ), data.getFloat( i, xCol ) ) );
      
      
      //rect(u0 + (barWidth * i), v0+h - adjustedHeight, barWidth, adjustedHeight);
      
    }

    
  }
  
  ArrayList<Bar> getBars() {return bars;}
  
  void draw() {  
 
    if(bars != null){
      for (Bar b: bars){
        
        b.draw(); 
      }
  
    }
  
  }

  void setColorsFromNames(String colorCol){
    
    //only set once to prevent changing every time draw is called
    if (colors == true) return;
    colors = true;
    //get name strings, then get unique only, then convert to list to use later with index
    names = Arrays.asList(data.getStringColumn(colorCol));
    uniqueNames = new HashSet<String>(names);
    uniqueNamesList = new ArrayList<String>();
    uniqueNamesList.addAll(uniqueNames);
    
    r = new ArrayList<Float>();
    g = new ArrayList<Float>();
    b = new ArrayList<Float>();
    rgb = new ArrayList<Integer>();
    
    //set colors for each name
    for (int i = 0; i < uniqueNames.size(); i++) {
     
      //add a random color for each unique name
      r.add(new Float(random(255)));
      g.add(new Float(random(255)));
      b.add(new Float(random(255)));

      rgb.add( color( r.get(i), g.get(i), b.get(i) ) );
      
    }   
    
    
  }

  void mousePressed() {  }

  void mouseReleased() {   }
  
}
