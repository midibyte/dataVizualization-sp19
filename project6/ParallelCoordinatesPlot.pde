class ParallelCoordinatesPlot extends Frame{
  
  Table data = null;
  ArrayList<Axis> axes = null;
  float[] max;
  float[] min;
  ArrayList<Line> lines = null;
  int noLines = 0;
  int sortCol = 0;
  ArrayList<Line> highlightedLines = new ArrayList<Line>();
  
  ParallelCoordinatesPlot(Table _data){
   
    data = _data;
    //sort the table by the first column;
    data.sort(sortCol);
  }
  
  void clearHighlighedLines(){
   
    highlightedLines = new ArrayList<Line>();
    
  }
  
  void keyPressed(){
   
    if (noLines == 0) noLines = 1;
    else noLines = 0;
    
  }
  
  void mousePressed(){
   
    for (Line l: lines){
     
      if (l.mouseInside() ) {
        
        
        if(highlightedLines.contains(l)) highlightedLines.remove(l);
        else highlightedLines.add(l);
      }
      
    }
    
  }
  
  void changeSortCol(){
   
    sortCol =+ 1;
    if ( sortCol >= data.getColumnCount() ) sortCol = 0;
    
    data.sort(sortCol);
    axes = null;
    lines = null;
    setupAxes();
    setupLines();
  }
  
  void draw(){
   


    if(lines != null){
      for(Line l: lines){ 
        if(noLines == 1) l.noLines();
        else l.yesLinesPlease();
        l.draw();
        
      }
    }
    
    if(lines != null){
      for(Line l: highlightedLines){ 
        if(noLines == 1) l.noLines();
        else l.yesLinesPlease();
        l.drawHighlighted();
        
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
    noLoop();
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
    loop();
    
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
          x = u0 + (spacing * w * i);
          
          temp.addPt(x, y);
          
          lines.add(temp);
        }
        
        //now the lines are already in the list
        else {
          Line temp = lines.get(j);
          
          float x, y;
          //map(value, start1, stop1, start2, stop2)
          y = map( data.getFloatColumn(i)[j], min(data.getFloatColumn(i)), max(data.getFloatColumn(i)), v0 + h, v0 );
          x = u0 + (spacing * w * i);
          
          temp.addPt(x, y);
          
          //lines.add(temp);
        }
        
      }
      
    }
  loop();
  }
}
