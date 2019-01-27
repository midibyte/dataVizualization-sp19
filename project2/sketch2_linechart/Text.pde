class Text extends Frame {
   
  String displayText;
  
  Text ( String _displayText ){
     
    displayText = _displayText;
  }
  
  void draw(){
    
    //shows frame
    //fill ( 255, 100, 100, 100 );
    ////noFill();
    //stroke( 0 );
    //rectMode( CORNER );
    //rect( u0, v0, w, h );
    
    rectMode( CENTER );
    fill( 255 );
    textSize( 32 );
    fill(0, 102, 153, 204);
    textAlign( CENTER, CENTER );
    text( displayText, w/2, h/2, w, h );
    
  }
  
}
