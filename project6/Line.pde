class Line{
  ArrayList<PVector> points = null;
  
  int noLines = 0;
  boolean highlighted;
  ArrayList<Float>  origYVals = new ArrayList<Float>();
  //ArrayList<Float>  origXVals = new ArrayList<Float>();
  
  void noLines(){
    noLines = 1;
  }
  void yesLinesPlease() { noLines = 0; }
  
  Line(){ points = new ArrayList<PVector>();}
  
  void addPt(float x, float y, float origY){
    //origXVals.add(origX);
    origYVals.add(origY);
    points.add( new PVector(x, y) );
  }
  
  void drawHighlighted(){
   
    if (noLines == 1) {
      
      stroke(255, 0, 0);
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
      stroke(255, 0, 0);
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
  
  //draw with some transparency to see overlap
  void draw(){
   colorMode(HSB, 360, 100, 100);
    if (noLines == 1) {
     
      //beginShape();
      noFill();
      //stroke(0, 0, 0, 80);
      stroke(230, 100, 100, 80);
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
      //stroke(0, 0, 0, 80);
      stroke(230, 100, 100, 80);
      for (PVector p: points){
        vertex(p.x, p.y);
        ellipse(p.x, p.y, 6, 6);
      }
      endShape();
      noFill();
      noStroke();
    }
    colorMode(RGB, 255, 255, 255);
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
