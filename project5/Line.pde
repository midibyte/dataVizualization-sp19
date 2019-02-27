class Line{
  ArrayList<PVector> points = null;
  
  int noLines = 0;
  boolean highlighted;
  
  void noLines(){
    noLines = 1;
  }
  void yesLinesPlease() { noLines = 0; }
  
  Line(){ points = new ArrayList<PVector>();}
  
  void addPt(float x, float y){
    points.add( new PVector(x, y) );
  }
  
  void drawHighlighted(){
   
    if (noLines == 1) {
      
      stroke(0, 240, 0);
      strokeWeight(3);
      for (PVector p: points){
        //vertex(p.x, p.y);
        ellipse(p.x, p.y, 6, 6);
      }
      noStroke();
      noFill();
      strokeWeight(1);
      
    }
    else{
     
      beginShape();
      stroke(0, 240, 0);
      strokeWeight(3);
      for (PVector p: points){
        vertex(p.x, p.y);
        ellipse(p.x, p.y, 6, 6);
      }
      endShape();
      noFill();
      noStroke();
      strokeWeight(1);
    }
    
  }
  
  void draw(){
   
    if (noLines == 1) {
     
      //beginShape();
      noFill();
      stroke(0, 0, 0, 170);
      for (PVector p: points){
        //vertex(p.x, p.y);
        ellipse(p.x, p.y, 6, 6);
      }
      //endShape();
      //noFill();
      noStroke();
    }
    else{
     
      beginShape();
      noFill();
      stroke(0, 0, 0, 170);
      for (PVector p: points){
        vertex(p.x, p.y);
        ellipse(p.x, p.y, 6, 6);
      }
      endShape();
      noFill();
      noStroke();
    }
  }
  
  //check all points in the line to see if inside any point
  boolean mouseInside(){
    int clickBuffer = 4;
    boolean inside = false;
    for (PVector p: points){
       inside |= (p.x-clickBuffer < mouseX) && (p.x+clickBuffer)>mouseX && (p.y-clickBuffer)< mouseY && (p.y+clickBuffer)>mouseY; 
    }
    if(inside){
      highlighted = true;
    }
    return inside;
  }
}
