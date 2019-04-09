class Histogram extends Frame{
  
  int bins;
  String useCol;
  Table data;
  float[] displayNumbers;
  float[] count;
  int max, min;
  Table histData = null;
  Barchart chart = null;
  
  Histogram(String _useCol, Table _data){
    
    useCol = _useCol;
    data = _data;
    
    
    float[] colData = data.getFloatColumn(useCol);
    max = ceil(max(colData));
    min = ceil(min(colData));
    //formula for number of bins to use
    bins = ( max - min ) / colData.length;
    bins = ceil(sqrt( colData.length ) );
    
    displayNumbers = new float[bins];
    count = new float[bins];
    
    for (int i = 0; i < bins; ++i){
      //displayNumbers[i] = min + (((i+1) /float(bins) ) * max-min);
      displayNumbers[i] = lerp(min, max, (i+1) /float(bins) );
      //get count for each bin
      
      for(int j = 0; j < colData.length; ++j){
        
        if(colData[j] > lerp(min, max, (i) /float(bins) ) && colData[j] < lerp(min, max, (i+1) /float(bins) ) ){
          count[i]++; 
        }
        
      }
      
    }
    
    for (int i = 0; i < bins; ++i){
      println(String.format( "up to %f count: %f", displayNumbers[i], count[i] ) ); 
      println(String.format( "max %d min %d data length %d number of bins %d", max, min,colData.length, bins) );
    }
    
    histData = new Table();
    
    histData.addColumn("bin");
    histData.addColumn("count");
    
    for (int i = 0; i < bins; ++i){
      TableRow newRow = histData.addRow();
      newRow.setFloat("bin", displayNumbers[i]);
      newRow.setFloat("count", count[i]);
    }
    
    histData.print();
    
  }
  
  Table getTable(){return histData;}
  
  void makeBarChart(){
   noLoop();
    chart = new Barchart(histData, histData.getColumnTitles()[0], histData.getColumnTitles()[1]);
    chart.setPosition(u0, v0, w, h);
    chart.setupPointList(); 
    chart.setupBars();
    
  }
  
  void draw(){
    if (chart != null) chart.draw();
  }
}
