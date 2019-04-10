class Histogram extends Frame{
  
  int bins;
  String useCol;
  Table data;
  float[] displayNumbers;
  float[] count;
  int max, min;
  Table histData = null;
  Barchart chart = null;
  Axis xAxis, yAxis, xAxisTitle;
  ArrayList<Bar> bars = null;
  
  Histogram(String _useCol, Table _data){
    noLoop();
    useCol = _useCol;
    data = _data;
    
    
    float[] colData = data.getFloatColumn(useCol);
    max = ceil(max(colData));
    min = ceil(min(colData));
    //formula for number of bins to use
    //bins = ( max - min ) / colData.length;
    bins = ceil(sqrt( colData.length ) ) /2;
    
    displayNumbers = new float[bins];
    count = new float[bins];
    
    for (int i = 0; i < bins; ++i){
      //displayNumbers[i] = min + (((i+1) /float(bins) ) * max-min);
      displayNumbers[i] = floor(lerp(min, max, (i+1) /float(bins) ));
      //get count for each bin
      
      for(int j = 0; j < colData.length; ++j){
        
        if(colData[j] > lerp(min, max, (i) /float(bins) ) && colData[j] < lerp(min, max, (i+1) /float(bins) ) ){
          count[i]++; 
        }
        
      }
      
    }
    
    //for (int i = 0; i < bins; ++i){
    //  println(String.format( "up to %f count: %f", displayNumbers[i], count[i] ) ); 
    //  println(String.format( "max %d min %d data length %d number of bins %d", max, min,colData.length, bins) );
    //}
    
    histData = new Table();
    
    histData.addColumn(useCol);
    histData.addColumn("count");
    
    for (int i = 0; i < bins; ++i){
      TableRow newRow = histData.addRow();
      newRow.setFloat(useCol, displayNumbers[i]);
      newRow.setFloat("count", count[i]);
    }
     //TableRow newRow = histData.addRow();
     // newRow.setFloat("bin", 0);
     // newRow.setFloat("count", 0);
    
    //histData.print();
    
    xAxis = new Axis(histData, useCol);
    yAxis = new Axis(histData, "count");
    xAxisTitle = new Axis(histData, useCol);
    
    
    
    
    loop();
  }
  
  void setupBars(){
    //make the bars
    
    bars = new ArrayList<Bar>();
    
    for( int i = 0; i < bins; ++i){
     
      float barWidth = w/ float(bins);
      float barHeight = map(count[i], min(count), max(count), 0, h);
      float barY = v0+h - barHeight;
      float barX = u0 + (barWidth*i);
      
      println(String.format("inside class bar x, y, w, h: %f, %f, %f, %f" , barX, barY, barWidth, barHeight) );
      
      Bar temp = new Bar(barX, barY, barWidth, barHeight, displayNumbers[i], count[i]);
      
      bars.add(temp);
    }
  }
  
  Table getTable(){return histData;}
  

  void draw(){
    if (chart != null) chart.draw();
    
    //yAxis.setPosition( u0 , v0, 50, h);
    //yAxis.yAxis();
    //yAxis.drawDistributedY(6);
    //yAxis.draw();

    for (Bar b: bars){ b.draw();}
    
    xAxis.setPosition( u0 + 4, v0 , w - 10, 40);
    xAxisTitle.setPosition( u0 + 4, v0 +h +10 , w - 10, 40);
    xAxis.noTitle();
    xAxis.drawDistributedXVertical(bins);
    xAxis.draw();
    xAxisTitle.draw();
  }
}
