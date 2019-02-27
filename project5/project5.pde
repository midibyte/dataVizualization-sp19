
import java.util.Arrays;
import java.util.List;

int X_AXIS = 1;
int Y_AXIS = 2;

float titleHeight;

Table myTable = null;
Frame myFrame = null;
Text title = null;
Text subtitle = null;
ParallelCoordinatesPlot plot = null;


void setup(){
  size(1000,600);  
  
  titleHeight = 80;
  
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
    
    //set title from file name
    title = new Text (selection.getName(), 0);
    title.setPosition( 0, 0, width, titleHeight );
    
    //subtitle
    subtitle = new Text("Press any key to toggle lines, click any point to highlight a line, press 'c' to clear highlights", 0);
    subtitle.setPosition(0, titleHeight/3, width, titleHeight);
    subtitle.setTitleSize(14);
    
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
  if( title != null ){
       
       title.draw();
       //plot.highlightFrame();
  }
  if( subtitle != null ){
       
       subtitle.draw();
       //plot.highlightFrame();
  }
  
}


void mousePressed(){
  plot.mousePressed();
  
}


void mouseReleased(){
  //myFrame.mouseReleased();
}

void keyPressed(){
 
  if (key == 'c') plot.clearHighlighedLines();
  else plot.keyPressed();
  
}


abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 14;
  int axisTitleFontSize = 18;
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
