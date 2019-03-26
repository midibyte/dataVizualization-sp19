class Splom extends Frame {
  
  Table data = null;
  ArrayList<ScatterPlot> scatterPlots = null;
  
  Splom(Table _data){
    data = _data;
  }
  
  void draw(){
    if( scatterPlots != null){
    
      //for (ScatterPlot p: scatterPlots) {
      for (int i = 0; i < scatterPlots.size(); i++) {
        //println(p.display);
        ScatterPlot p = scatterPlots.get(i);
        if (p.display) {
          p.draw();
          //println("drew a splom");
          //p.drawBorder();
        }

      }
    }
  }
  
  void setupSplom(float spacing){
    noLoop();
    //needs setPosition first
    println("setting up splom");
    scatterPlots = new ArrayList<ScatterPlot>();
    //float verticalAxisWidth = 0;
    float splom_w = w;
    float splom_h = h;
      int displayX = 0;
      //setup each scatter plot cell and add to list for drawing later
      for (int y = 0; y < myTable.getColumnCount(); y++){
        for (int x = 0; x < myTable.getColumnCount(); x++){
          

          //size of each plot
          float cellWidth = ( splom_w / myTable.getColumnCount() ) - spacing;
          float cellHeight = ( splom_h / myTable.getColumnCount() ) - spacing;
          
          //if ( myTable.getColumnType(x) == Table.STRING || myTable.getColumnType(y) == Table.STRING) continue;
          
          ScatterPlot temp = new ScatterPlot( myTable, myTable.getColumnTitles()[x], myTable.getColumnTitles()[y]);
          
          temp.setPosition( u0 + (x * cellWidth) + ( spacing * x ), 
                          v0 + (y * cellHeight)  + ( spacing * y ), 
                          cellWidth, cellHeight );
          temp.setupPointList();   
          temp.setColorsX();
          temp.noLabels();
          
          if(x == y) temp.displayFalse();
          
          if(x > displayX) temp.displayFalse();
          
          
          
          scatterPlots.add( temp );
          
          //println("created splom: w, h, x, y : "+ cellWidth + ", " + cellHeight + ", " 
                  //+ (u0 + (x * cellWidth) + ( spacing * x )) + ", " + (v0 + (y * cellHeight)  + ( spacing * y )));
  
        }
        displayX++;
      }
    loop();
  }
  
}
