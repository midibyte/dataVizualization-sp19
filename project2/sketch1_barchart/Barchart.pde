

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
  
  Barchart( Table _data, String _useColumn ) {
    data = _data;
    useColumn = _useColumn;              //will be label at bottom of chart
    rows = data.getRowCount();
    data.print();
    displayCol = data.getColumnIndex(useColumn);  //column number to use for bars
    
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
  
  void labelsBelowPoints(){
   
    //points are locations to draw labels
    //get text and color info from use column
    
    for(int i = 0; i < points.size(); i++){
     
      
      String temp = String.format( "%.2f", data.getFloatColumn(useColumn)[i] );
      
      textAlign(CENTER, TOP);
      textSize( 20 );
      fill(255);
      //stroke(1);
      text( temp, points.get(i).x, points.get(i).y );
      //points.get(i).print();
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
      //temp.print();
      
      //println("debug: " + "data val: " + data.getFloat(i, displayCol) + " adjH: " + adjustedHeight + " u0 " + u0 + " v0 " + v0 + " i: " + i);
      //println("displayCol: " + displayCol);
      
    }

  }
  
  void draw() {  
    
    //println("frame(w, h, u0, v0)" + w +", " + h + ", " + u0 + ", " + v0);
    
    noFill();
    stroke(0);
    rectMode(CORNER);
    rect(u0, v0, w, h);
    
    String[] party = data.getStringColumn(3);
    
    //width of each bar - use window width
    float barWidth = w / rows;
    //data column to use
    
    
    for (int i = 0; i < data.getRowCount(); i++){

      //map: value, current_start, current_end, target_start, target_end
      //reverse target start and end
      float adjustedHeight = map( data.getFloat( i, displayCol ), dataMin, dataMax, 0, h );
      
      //x, y, (top left) x, y (bottom right)
      //use trim to trim whitespace
      //println("party in col " + party[i] + "equals dem? " + party[i].trim().equals( "DEM" ) );
      
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
         
      }
      else {
        if ( party[i].trim().equals( "DEM" ) ) fill(0, 0, 255);
        else fill (255, 0, 0);
        //fill(100);
        stroke(0);
      }
      
      
      rect(u0 + (barWidth * i), v0+h - adjustedHeight, barWidth, adjustedHeight);
      
      
      //println("debug: " + "data val: " + data.getFloat(i, 1) + " adjH: " + adjustedHeight + " i: " + i);
      //println("displayCol: " + displayCol);
      
    }
    
    //convert max and min from data to fit in window
   
  
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
