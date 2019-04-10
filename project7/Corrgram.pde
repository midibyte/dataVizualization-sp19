class Corrgram extends Frame{
  Table data;
  float[][] pccValues;
  float[][] srcValues;
  float[] meanValues;
  float [] stdevValues;
  int cols;
  ArrayList<Box> boxes;
  
  Corrgram(Table _data){
    data = _data;
    cols = data.getColumnCount();
    
    pccValues = new float[cols][cols];
    srcValues = new float[cols][cols];
    meanValues = new float[cols];
    stdevValues = new float[cols];
    
    for (int i = 0; i < cols; ++i){
      meanValues[i] = mean (data.getFloatColumn(i));
      stdevValues[i] = stdev (data.getFloatColumn(i));
      for(int j = 0; j < cols; ++j){
        
        
        pccValues[i][j] = pcc(data.getFloatColumn(i), data.getFloatColumn(j));
        println(pccValues[i][j]);
        srcValues[i][j] = src(data.getFloatColumn(i), data.getFloatColumn(j));
        println(srcValues[i][j]);
      }
    }
    
  }
  
  float mean(float[] array){
    float sumX = 0;
    float meanX = 0;
    
    for (int i = 0; i < array.length; ++i){
      sumX += array[i];

      
    }

    meanX = sumX / array.length;
    
    return meanX;
  }

  float stdev(float[] array){
    float sumX = 0;
    float meanX = 0;
    
    for (int i = 0; i < array.length; ++i){
      sumX += array[i];
    }

    meanX = sumX / array.length;
    
    float stdev = 0;
    
    for (int i = 0; i < array.length; ++i){
      float temp = array[i] - meanX;
      temp = temp* temp;
      
      stdev += temp;
      
    }
    
    stdev = stdev * (1/float(array.length) );
    
    return stdev;
  }
  
  //pearson correlation coefficient
  //formula from wikipedia
  float pcc(float[] arrayX, float[] arrayY){
    
    float sumX, sumY, meanX, meanY;
    sumX = sumY = meanX = meanY = 0;
        
    float sumXY = 0;
    float sumXX = 0;
    float sumYY = 0;
    
    for (int i = 0; i < arrayX.length; ++i){
      sumX += arrayX[i];
      sumY += arrayY[i]; 
      
      sumXY += (arrayX[i] * arrayY[i]);
      sumXX += (arrayX[i] * arrayX[i]);
      sumYY += (arrayY[i] * arrayY[i]);
      
    }
    

    
    meanY = sumY / arrayY.length;
    meanX = sumX / arrayX.length;
    
    float pcc = 0;

    pcc = (sumXY - arrayX.length*meanX*meanY) / ( (sqrt(sumXX - ( arrayX.length * meanX*meanX) ) ) * sqrt( sumYY - (arrayX.length * meanY * meanY)));
    
    
    return pcc;
  }
  
  
  
  //spearman rank correlation
  float src(float[] arrayX, float[] arrayY) {
    
    Table xy = new Table();
    
    xy.addColumn("x");
    xy.addColumn("y");
    xy.addColumn("rankX");
    xy.addColumn("rankY");
    xy.addColumn("d");
    
    //create a new table then sort the table
    for(int i = 0; i < arrayX.length; ++i){
      TableRow newRow = xy.addRow();
      newRow.setFloat("x", arrayX[i]);
      newRow.setFloat("y", arrayY[i]);
    }
    
    xy.sort("x");
    
    for (int i = 0; i < arrayX.length; ++i){
      
      TableRow temp = xy.getRow(i);
      temp.setFloat("rankX", i);
      
    }
    
    //sort by y col then set rank
    xy.sort("y");
    
    for (int i = 0; i < arrayX.length; ++i){
      
      TableRow temp = xy.getRow(i);
      temp.setFloat("rankY", i);
      
    }
    
    for (int i = 0; i < arrayX.length; ++i){
      
      TableRow temp = xy.getRow(i);
      temp.setFloat("d", abs(xy.getFloat(i, "rankX") - xy.getFloat(i, "rankY") ) );
      
    }
    
    float sumDD = 0;
    
    for ( int i =0; i < arrayX.length; ++i){
      sumDD += xy.getFloat(i, "d") * xy.getFloat(i, "d");
    }
    
    //println("printing table");
    //xy.print();
    
    float src = 1 - ( ( 6 * sumDD ) / ( arrayX.length * ( arrayX.length*arrayX.length - 1 ) )  );
    
    return src;
  }
  
  void setupBoxes(){
    
    boxes = new ArrayList<Box>();
    
    float boxW = w/cols;
    float boxH = h/ cols;
    
    for (int i = 0; i < cols; ++i){
      for(int j = 0; j < cols; ++j){
        //if (i == j) continue;
        float boxX = u0 + (i * boxW);
        float boxY = v0 + (j * boxH);
        
        if(i == j){
          Box temp = new Box(boxX, boxY, boxW, boxH, String.format( "%s mean", data.getColumnTitles()[i] ) , "stdev", String.format("%.2f, %.2f", meanValues[i], stdevValues[i]) );
          //temp.setTitle("PCC");
          temp.textOnly();
          boxes.add(temp);
        }
        
        else if (i > j) {
          //top right is pcc
          Box temp = new Box(boxX, boxY, boxW, boxH, pccValues[i][j], data.getColumnTitles()[i], data.getColumnTitles()[j]);
          temp.setTitle("PCC");
          boxes.add(temp);
        }
        else{
          //bottom left is src
          Box temp = new Box(boxX, boxY, boxW, boxH, srcValues[i][j], data.getColumnTitles()[i], data.getColumnTitles()[j]);
          temp.setTitle("SRC");
          temp.setColor(1);
          boxes.add(temp);
        }
        //Box temp = new Box(boxX, boxY, boxW, boxH, pccValues[i][j], data.getColumnTitles()[i], data.getColumnTitles()[j]);
        
        
      }
      
    }
    
  }
  
  void draw() {
    
    for (Box b: boxes) b.draw();
  
  }
  
}
