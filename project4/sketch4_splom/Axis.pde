class Axis extends Frame {
  
  Table data;
  String useColumn; //column to use for the marks on the x axis
  float[] numbers;
  float max, min;
  float rotateAmount = 0; //default rotate to x axis
  
  Axis ( Table _data, String _useColumn ) {
     data = _data;
     useColumn = _useColumn;
     numbers = data.getFloatColumn(useColumn);
     //println(numbers);
     Arrays.sort(numbers);
     min = 0.0;
     max = numbers[numbers.length - 1];
     println(min);
     println(max);
  }
  
  void draw() {

    if ( rotateAmount == 0 ) { 
      drawAxisTitleX(); 
      //drawLabelsX(); 
    }
    
    else {
      //drawDistributed();
      //drawAxisTitle();
    }
  }
  
  void setCol(String _useColumn){
    useColumn = _useColumn;
    numbers = data.getFloatColumn(useColumn);
     //println(numbers);
     Arrays.sort(numbers);
     min = 0.0;
     max = numbers[numbers.length - 1];
     println(min);
     println(max);
  }
  
  void xAxis () {
    rotateAmount = 0; 
  }
  
  void yAxis () {
    rotateAmount = HALF_PI; 
  }
  
  
  
  void drawLabelsX() {
    
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( CENTER , CENTER );
    textSize( axisFontSize );
    fill(0);
    
    for ( int i = 0; i < numbers.length; i++ ){
      
      float x, y, textW, textH;
      
      x = u0 + ( w/ ( 2 * numbers.length ) ) + ( w / numbers.length ) * i;
      y = v0 + h/4;
      textW = w / numbers.length;
      textH = h / 4;

      String text = String.format( "%.0f", numbers[i] );
      
      text( text, x, y, textW, textH );
      
    }  
  }
  
  void drawAtNumbers() {
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( RIGHT, CENTER );
    textSize( axisFontSize );
    fill(0);
    
    for ( int i = 0; i < numbers.length; i++ ){
      
      //map: value, current_start, current_end, target_start, target_end
      float new_h = map( numbers[i], 0, max, v0 + h, v0 );
      
      String text = numbers[i] + " -";
      
      text( text, u0 + w/2, new_h, w, h / numbers.length );
      
    }
  }
  
  //draw all the numbers from the column along the y axis
  void drawDistributedAll() {
    
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( RIGHT, CENTER );
    textSize( axisFontSize );
    fill(0);
    
    for ( int i = 0; i <= numbers.length; i++ ){
      
      float h_Increment = h / numbers.length;
      String text = String.format( "%.2f -", ( (max / numbers.length) * i ) );
      
      text( text, u0 + w/2, v0 + h - ( h_Increment * i ), w, h / numbers.length );
      
    }
    
    
  }
  
  //draw count numbers along the y axis from min to max
  void drawDistributedY(int count) {
    //adjust count so that the correct number of markings will show
    count -= 1;
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( CENTER, CENTER );
    textSize( axisFontSize );
    fill(0);
    
    float interval = h / count;
    float yPos = v0 + h;  //set starting  y coord
    float displayNum = min;
    
    for (int i = 0; i <= count; i++ ){
     
      
      String text = String.format("%.1f", displayNum);
      
      //draw text with room for axis  lines
      text( text, u0 + w/2, yPos, w, h / count );
      
      
      stroke(0);
      line(u0 + w, yPos, u0 + w - axisFontSize, yPos);
      
      //update yPos
      yPos -= interval;
      displayNum += (max / count);
      
    }
    
  }
  
  //draw count numbers along the x axis from min to max
  void drawDistributedX(int count) {
    //adjust count so that the correct number of markings will show
    count -= 1;
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( CENTER, CENTER );
    textSize( axisFontSize );
    fill(0);
    
    float interval = w / count;
    float xPos = u0;  //set starting  x coord
    float displayNum = min;
    
    for (int i = 0; i <= count; i++ ){
     
      
      String text = String.format("%.0f", displayNum);
      stroke(0);
      text( text, xPos, v0 + h/4, w, h / count );
      
      line( xPos, v0 + h/4 - axisFontSize, xPos, v0);
      
      //update xPos
      xPos += interval;
      displayNum += (max / count);
      
    }
    
  }
  void drawAxisTitle() {
     //y axis
     float x, y;
     
     x = u0 + w/4;
     y = v0 + h/2;
     textSize( axisTitleFontSize );
     fill(0);
     pushMatrix();
     translate(x,y);
     rotate(rotateAmount);
     textAlign(CENTER, CENTER);
     text(useColumn,0,0);
     popMatrix();
     
  }
  
  void drawAxisTitleX() {
     //x axis
     float x, y;
     
     x = u0 + w/2;
     y = v0 + ( h/4 * 3 );    //place at bottom quarter
     textSize( axisTitleFontSize );
     fill(0);
     pushMatrix();
     translate(x,y);
     rotate(rotateAmount);
     textAlign(CENTER, CENTER);
     text(useColumn,0,0);
     popMatrix();
     
  }
  
  //taken from processing.org
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
  
    noFill();
  
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
  
  //draw gradient at position provided from setPostion
  void drawGradient( color c1, color c2, int axis ) {
  
    
    float x, y;

    
    x = u0;
    y = v0;

    
    noFill();
  
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (float i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (float i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}
