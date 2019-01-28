public class Labels{
  ArrayList<Point> points;
  Table data;
  String useColumn, colorColumn;
  List<String> names;
  Set<String> uniqueNames;
  ArrayList<Float> r, g, b;
  boolean colors = false;
  //class for making labels on points or bars
  
  Labels(Table _data, String _useColumn, ArrayList<Point> _points){
    points = new ArrayList<Point>(_points);
    data = _data;
    useColumn = _useColumn;
  }
  
  Labels(Table _data, String _useColumn, String _colorColumn, ArrayList<Point> _points){
    points = _points;
    data = _data;
    useColumn = _useColumn;
    colorColumn = _colorColumn;
    colors = true;
    setUniqueNames();
  }
  
  void setUniqueNames() {
    
    names = Arrays.asList(data.getStringColumn(colorColumn));
    uniqueNames = new HashSet<String>(names);
    //set colors for each name
    for (int i = 0; i < uniqueNames.size(); i++) {
     
      //add a random color for each unique name
      r.add(random(255));
      g.add(random(255));
      b.add(random(255));
    }
  }
  
  void labelsBelowPoints(){
   
    //points are locations to draw labels
    //get text and color info from use column
    
    for(int i = 0; i < points.size(); i++){
     
      
      String temp = String.format( "%.2f", data.getFloatColumn(useColumn)[i] );
      
      textAlign(RIGHT, BOTTOM);
      textSize( 16 );
      fill(0);
      //stroke(1);
      text( temp, points.get(i).x, points.get(i).y );
      points.get(i).print();
    }
   

  }

  void draw(){
    
   
    labelsBelowPoints();
    
  }
}
