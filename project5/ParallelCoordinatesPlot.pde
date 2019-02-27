class ParallelCoordinatesPlot extends Frame{
  
  Table data = null;
  ArrayList<Axis> axes = null;
  float[] max;
  float[] min;
  ArrayList<Line> lines = null;
  
  
  ParallelCoordinatesPlot(Table _data){
   
    data = _data;
    data.sort(0);
  }
  
  void draw(){
   

    if(lines != null){
      for(Line l: lines){ 
        l.draw();
      }
    }
    
    //draw an axis line for each data column
    if(axes != null){
      for(Axis a: axes){
        a.drawDistributedY(6);
        a.draw();
        //a.highlightFrame();
      }
    }
    
  }
  
  //set maxes and mins to use for setting the positions of points
  
  void setColsMaxMin(){
   
    
    max = new float[ data.getColumnCount() ];
    min = new float[ data.getColumnCount() ];
    
    for (int i = 0; i < data.getColumnCount(); i++){
      
      float[] temp = data.getFloatColumn(i);
      
      min[i] = min(temp);
      max[i] = max(temp);
      
    }
    
  }
  
  
  
  void setupAxes(){
    float axisW, axisH;
    axisW = 50;
    axes = new ArrayList<Axis>();
    
    for (int i = 0; i < data.getColumnCount(); i++){
      //setup an axis for each data column
      int numCols = data.getColumnCount();
      float spacing = 1 / (float)(numCols - 1);
      println("x, adjustment: " + (spacing) + "\n");
      Axis temp = new Axis(data, data.getColumnTitles()[i] );
      temp.setPosition(u0 + (spacing * w * i) - 50, v0, axisW, h);
      temp.yAxis();
      axes.add(temp);
    }
    
  }
  
  void setupLines(){
    noLoop();
    lines = new ArrayList<Line>();
    //go through each column
    for (int i = 0; i < data.getColumnCount(); i++){
      
      int numCols = data.getColumnCount();
      float spacing = 1 / (float)(numCols - 1);
      
      //now go through each element in column i
      for (int j = 0; j < data.getFloatColumn(i).length; j++){
        
        //need to add new lines the first time around
        if (i == 0){
          Line temp = new Line();
          
          float x, y;
          //map(value, start1, stop1, start2, stop2)
          y = map( data.getFloatColumn(i)[j], min(data.getFloatColumn(i)), max(data.getFloatColumn(i)), v0 + h, v0 );
          x = u0 + (spacing * w * i) - u0;
          
          temp.addPt(x, y);
          
          lines.add(temp);
        }
        
        //now the lines are already in the list
        else {
          Line temp = lines.get(j);
          
          float x, y;
          //map(value, start1, stop1, start2, stop2)
          y = map( data.getFloatColumn(i)[j], min(data.getFloatColumn(i)), max(data.getFloatColumn(i)), v0 + w, v0 );
          x = u0 + (spacing * w * i) - u0;
          
          temp.addPt(x, y);
          
          //lines.add(temp);
        }
        
      }
      
    }
  loop();
  }
}
