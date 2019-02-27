class Line{
  ArrayList<PVector> points = null;
  
  Line(){ points = new ArrayList<PVector>();}
  
  void addPt(float x, float y){
    points.add( new PVector(x, y) );
  }
  
  void draw(){
    //beginShape();
    noFill();
    stroke(3);
    for (PVector p: points){
      //vertex(p.x, p.y);
      ellipse(p.x, p.y, 6, 6);
    }
    //endShape();
    //noFill();
  }
}
