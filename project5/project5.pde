
import java.util.Arrays;

int X_AXIS = 1;
int Y_AXIS = 2;

Table myTable = null;
Frame myFrame = null;
ParallelCoordinatesPlot plot = null;


void setup(){
  size(1000,600);  
  selectInput("Select a file to process:", "fileSelected");
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    // TODO: create object
    
    plot = new ParallelCoordinatesPlot(myTable);
    plot.setPosition( 50, 50, width - 100, height - 100 );
    plot.setupAxes();
    plot.setupLines();
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( plot != null ){
       
       plot.draw();
       //plot.highlightFrame();
  }
}


void mousePressed(){
  //myFrame.mousePressed();
}


void mouseReleased(){
  //myFrame.mouseReleased();
}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 14;
  int axisTitleFontSize = 16;
  int titleFontSize = 20;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 8;
     
  void setTitleSize(int newSize){
    titleFontSize = newSize;
  } 
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void setPosition( float u0, float v0, float w, float h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();

  void mousePressed(){ }
  void mouseReleased(){ }
  
  void highlightFrame() {
    
    //draw a rectagle to highlight the frame to confirm its position
    fill (255, 100, 100, 100);
    //noFill();
    stroke(0);
    rectMode(CORNER);
    rect(u0, v0, w, h);
    
  }
  
  void drawBorder() {
   
    noFill();
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER);
    rect(u0, v0, w, h);
  }
  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
