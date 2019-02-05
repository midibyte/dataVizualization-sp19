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
  
  void setXCol(String _useX) { useX = _useX; setupPointList(); }
  void setYCol(String _useY) { useY = _useY; setupPointList(); }
  
  void setupPointList() {  

    //get data arrays from table
    dataX = data.getFloatColumn(useX);
    dataY = data.getFloatColumn(useY);
    
    Arrays.sort(dataX);
    Arrays.sort(dataY);
    
    max_x = dataX[dataX.length - 1];
    max_y = dataY[dataY.length - 1];
    min_x = min_y = 0;
    
    points = new ArrayList<Point>();
    
    //map x and y data to frame size
    //x: u0, u0+w
    //y: v0, v0+h
    
    for (int i = 0; i < dataX.length; i++){
     
      float newX = map(dataX[i], min_x, max_x, u0, u0 + w);
      //reverse target to get correct position
      float newY = map(dataY[i], min_y, max_y, v0 + h, v0);
      //float newY = map(dataY[i], min_y, max_y, v0, v0 +h);
      
      points.add( new Point(newX, newY) );
      
    }
  }
  
  
  void draw(){
    
    if (points != null){
      for (Point p: points){
       
        fill(0);
        stroke(0);
        ellipse(p.x, p.y, pointSize, pointSize);
        
      }
    
  }
  }
  
}
