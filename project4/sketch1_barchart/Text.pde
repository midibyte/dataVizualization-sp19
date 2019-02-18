class Text extends Frame {
   
  String displayText, title;
  float rotationVal;
  boolean colors = false;
  ArrayList<String> uniqueNamesList = null;
  ArrayList<Float> r, g, b;
  List<Integer> rgb;
  
  Text ( String _displayText, float _rotationVal ){
     
    displayText = _displayText;
    rotationVal = _rotationVal;
  }
  
  Text (String _title, ArrayList<String> _uniqueNamesList, float _rotationVal ){
    title = _title;
    uniqueNamesList = _uniqueNamesList;
    rotationVal = _rotationVal;
  }
  
  void draw(){

    if(uniqueNamesList == null){
      rectMode( CENTER );
      //fill( 255 );
      textSize( titleFontSize );
      fill(0, 102, 153, 204);
      textAlign( CENTER, TOP );    
      pushMatrix();
      translate( u0 + (w/2), v0 + (h/2) );
      rotate(rotationVal);
      text( displayText, 0, 0, w, h );
      popMatrix();
    }
    else{
      textFromList();
    }

  }
  
  void textFromList(){
    
    float textSize = subtitleFontSize;
    float textOffset = textSize;
    rectMode( CENTER );
    textAlign( CENTER, CENTER );
    fill(0, 102, 153, 204);
    textSize( textSize );
    pushMatrix();
    translate( u0 + (w/2), v0 + textOffset );
    text(title, 0, 0, w, h );
    popMatrix();
    textOffset += textSize;
    
    for (int i = 0; i < uniqueNamesList.size(); i++){
      rectMode( CENTER );
      
      textSize( textSize );
      
      if (colors == false) fill(0, 102, 153, 204);
      
      else{
       
        fill(rgb.get(i));
        
      }
      
      textAlign( CENTER, CENTER );    
      pushMatrix();
      translate( u0 + (w/2), v0 + textOffset );
      rotate(rotationVal);
      text( uniqueNamesList.get(i), 0, 0, w, h );
      popMatrix();
      
      textOffset += textSize;
    }
    
  }
  
  void setTextColors( ArrayList<Integer> _rgb){
    rgb = _rgb;
    colors = true;
    
    
  }
  
}
