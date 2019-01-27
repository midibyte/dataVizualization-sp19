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
     println(numbers);
     Arrays.sort(numbers);
     min = 0.0;
     max = numbers[numbers.length - 1];
     println(max);
  }
  
  void draw() {
    

    if ( rotateAmount == 0 ) { 
      drawAxisTitleX(); 
      drawLabelsX(); 
    }
    
    else {
      
      //drawAtNumbers();
      drawDistributed();
      drawAxisTitle();
      
    }
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
    textSize( 16 );
    fill(0);
    
    for ( int i = 0; i < numbers.length; i++ ){
      
      float x, y, textW, textH;
      
      x = u0 + ( w/ ( 2 * numbers.length ) ) + ( w / numbers.length ) * i;
      y = v0 + h/4;
      textW = w / numbers.length;
      textH = h / 4;
      
      float offset = ( ( 1 / ( numbers.length * 2 ) ) * w );
      String text = String.format( "%.0f", numbers[i] );
      
      text( text, x, y, textW, textH );
      
      //println( "x: " + x + " i: " + i );
      
    }
    
  }
  
  void drawAtNumbers() {
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( RIGHT, CENTER );
    textSize( 15 );
    fill(0);
    
    for ( int i = 0; i < numbers.length; i++ ){
      
      //map: value, current_start, current_end, target_start, target_end
      float new_h = map( numbers[i], 0, max, v0 + h, v0 );
      
      String text = numbers[i] + " -";
      
      text( text, u0 + w/2, new_h, w, h / numbers.length );
      
    }
  }
  
  void drawDistributed() {
    
    //center of text box is the point given
    rectMode( CENTER );
    textAlign( RIGHT, CENTER );
    textSize( 16 );
    fill(0);
    
    for ( int i = 0; i <= numbers.length; i++ ){
      
      float increment = 1 / numbers.length;
      float h_Increment = h / numbers.length;
      String text = String.format( "%.2f -", ( (max / numbers.length) * i ) );
      //String text = ( (max / numbers.length) * i ) + " -";
      
      text( text, u0 + w/2, v0 + h - ( h_Increment * i ), w, h / numbers.length );
      
    }
    
    
  }
  void drawAxisTitle() {
     //y axis
     float x, y;
     
     x = u0 + w/4;
     y = v0 + h/2;
     textSize( 24 );
     fill(0);
     pushMatrix();
     translate(x,y);
     rotate(rotateAmount);
     text(useColumn,0,0);
     popMatrix();
     
  }
  
  void drawAxisTitleX() {
     //x axis
     float x, y;
     
     x = u0 + w/2;
     y = v0 + ( h/4 * 3 );    //place at bottom quarter
     textSize( 24 );
     fill(0);
     pushMatrix();
     translate(x,y);
     rotate(rotateAmount);
     text(useColumn,0,0);
     popMatrix();
     
  }
}
