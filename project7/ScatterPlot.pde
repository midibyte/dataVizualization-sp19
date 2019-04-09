public class ScatterPlot extends Frame{
  //creates its own axes
  Table data;
  //column to display on each column
  String useX, useY;
  float[] dataX, dataY;
  ArrayList<Point> points = null;
  float max_x, max_y, min_x, min_y;
  
  Axis xAxis = null;
  Axis yAxis = null;
  
  boolean xAxisOn = true;
  boolean yAxisOn = true;
  boolean xTitleOnly = false;
  boolean yTitleOnly = false;
  
  ArrayList<Point> highlightedPoints = new ArrayList<Point>();
  void clearHighlight() { highlightedPoints.clear(); }
  
  void noLabels() {xAxisOn = false; yAxisOn = false;}
  void xTitleOnly() {xTitleOnly = true;}
  void yTitleOnly() {yTitleOnly = true;}
  
  ScatterPlot(Table _data, String _useX, String _useY){
   
    data = _data;
    useX = _useX;
    useY = _useY;
    //axis markings
    yAxis = new Axis(myTable, useY);
    xAxis = new Axis(myTable, useX);

    
  }
  
  void setXCol(String _useX) { useX = _useX; setupPointList(); setColorsX(); }
  void setYCol(String _useY) { useY = _useY; setupPointList(); setColorsX(); }
  
  ArrayList<Point> getPointList() {return points;}
  
  void addHighlightFromOrig(float x, float y){
    //println("xy " + x + y);
    if (points != null){
      for (Point p: points){
        //println(p.origX);
        if(p.origX == x && p.origY == y) { 
          println("found match");
          if (highlightedPoints.contains(p) ) break;
          p.print();
          highlightedPoints.add(p); 
          break; 
        }
      }
    }
  }
  void addHighlightFromOrig(float y){
    //println("xy " + x + y);
    if (points != null){
      for (Point p: points){
        //println(p.origX);
        if( p.origY == y) { 
          println("found match");
          if (highlightedPoints.contains(p) ) break;
          p.print();
          highlightedPoints.add(p); 
          break; 
        }
      }
    }
  }
  
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

    if (points != null){

      
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
        
        if(highlightedPoints.contains(points.get(i))){
          fill(255, 0, 0);
          stroke(255, 0, 0);
          ellipse(points.get(i).x, points.get(i).y, pointSize *2, pointSize *2);
          //println("drawing highlighted point");
        }
        
        //stroke(0);
        
        
      }
      
      if( yAxis != null && yAxisOn){
       
         yAxis.setPosition( u0 , v0, 50, h);
         yAxis.yAxis();
         yAxis.drawDistributedY(6);
         yAxis.draw();
      }

      
      if( xAxis != null && xAxisOn ){
         // +4 aligns left side with y axis  
         xAxis.setPosition( u0 + 4, v0 + h + 10, w - 10, 50);
         xAxis.drawDistributedX(3);
         
         xAxis.draw();
      }
      
      if(xTitleOnly){
        xAxis.setPosition( u0 + 4, v0 + h + 10, w - 10, 50);
        xAxis.draw();
      }
      if(yTitleOnly){
        yAxis.setPosition( u0 , v0 + h/2, 50, h);
        yAxis.yAxis();
        yAxis.draw();
      }
      
    
    }
  }
  void mousePressed() {
    
    for(Point p: points){
      if(p.mouseInside()) {
        //println("inside bar" + b.origX);
        highlightedPoints.add(p);
      }
    }
    
  }
}
