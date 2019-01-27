class Axis extends Frame {
  
  Table data;
  String useColumn; //column to use for the marks on the x axis
  float[] numbers;
  float max, min;
  
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
    
    //outline frame boundary
    


    
    
    
    drawAtNumbers();
   
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
}
