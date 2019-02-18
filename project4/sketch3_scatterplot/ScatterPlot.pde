public class ScatterPlot extends Frame{
  
  Table data;
  //column to display on each column
  String useX, useY;
  float[] dataX, dataY;
  ArrayList<Point> points = null;
  float max_x, max_y, min_x, min_y;
  
  ScatterPlot(Table _data, String _useX, String _useY){
   
    data = _data;
    useX = _useX;
    useY = _useY;
    

    
  }
  
  void setXCol(String _useX) { useX = _useX; setupPointList(); setColorsX(); }
  void setYCol(String _useY) { useY = _useY; setupPointList(); setColorsX(); }
  
  ArrayList<Point> getPointList() {return points;}
  
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
      
      points.add( new Point(newX, newY, data.getFloatColumn(useX)[i], data.getFloatColumn(useY)[i] ) );
      
    }
  }
  
  void setColorsX(){
     if(points == null) {return;}
     
     colorMode(HSB, 360, 100, 100);
     
     for(Point p: points){
      
       //hue from yellow to red
       //p.setColor( color ( map( p.x, u0, u0+w, 50, 0 ), 100, 100 ) );
       //saturation from white to red
       p.setColor( color ( 230, map( p.x, u0, u0+w, 15, 100 ), 100 ) );
       
     }
     
     colorMode(RGB, 255, 255, 255);
    
  }
  
  void draw(){
    //println(points.size());
    //println(dataX.length);
    if (points != null){
      //for (Point p: points){
        
      //  if (p.ptColor != -1){
      //    fill(p.ptColor);
      //    stroke(p.ptColor);
      //    ellipse(p.x, p.y, pointSize, pointSize);
      //  }
      //  else{
      //    fill(0);
      //    stroke(0);
      //    ellipse(p.x, p.y, pointSize, pointSize);
      //  }
        
      //  //stroke(0);
        
        
      //}
      for (int i = 0; i < points.size(); i++){
        //println(i);
        //points.get(i).print();
        
        if (points.get(i).ptColor != -1){
          fill(points.get(i).ptColor);
          stroke(points.get(i).ptColor);
          ellipse(points.get(i).x, points.get(i).y, pointSize, pointSize);
        }
        else{
          fill(0);
          stroke(0);
          ellipse(points.get(i).x, points.get(i).y, pointSize, pointSize);
        }
        
        //stroke(0);
        
        
      }
    
  }
  }
  
}
