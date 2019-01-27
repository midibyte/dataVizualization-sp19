import java.util.Arrays;
import java.util.Collections;

Table myTable = null;
Frame myFrame = null;
Text title = null;
Text legend = null;
Axis x_axis = null;
Axis y_axis = null;
float displayFractionWidth, displayFractionHeight;
String xLabelCol, displayDataCol;

//get input file
void setup(){
  size(800,800);
  displayFractionWidth = width/8;
  displayFractionHeight = height/8;
  selectInput("Select a file to process:", "fileSelected");
}

//file open dialog, load into table object, create barchart with Barchart Class
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    
    //set data to display from the table
    xLabelCol = myTable.getColumnTitles()[0];
    displayDataCol = myTable.getColumnTitles()[2];
    
    myFrame = new Barchart( myTable, displayDataCol );
    
    //set title from file name
    title = new Text (selection.getName());
    
    
    legend = new Text ("DEM, REP");
    
    y_axis = new Axis( myTable, displayDataCol );
    
    x_axis = new Axis( myTable, xLabelCol );
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( myFrame != null ){
       //myFrame.setPosition( 0, 100, 800, 600 );
       //myFrame.setPosition( 0, height/8, width, height/8 * 6);
       myFrame.setPosition( displayFractionWidth, displayFractionHeight, displayFractionWidth * 6, displayFractionHeight * 6);
       //myFrame.setPosition(0,0, width, height);
       
       //rect(200, 200, width - 300, height -300);
       //stroke(10);
       //fill(255, 255, 255, 255);
       
       myFrame.draw();
  }
  
  if ( title != null ){
    
    title.setPosition( 0, 0, 800, 100 );
    
    title.draw();
  }
  
  if ( y_axis != null ){
    
    y_axis.setPosition( 0, displayFractionHeight, displayFractionWidth, displayFractionHeight * 6);
    y_axis.yAxis();
    y_axis.draw();
  }
  if ( x_axis != null ){
    
    x_axis.setPosition( displayFractionWidth, displayFractionHeight * 7, displayFractionWidth * 6, displayFractionHeight);
    //set to x axis for text
    x_axis.xAxis();
    //x_axis.highlightFrame();
    x_axis.draw();
  }
}


void mousePressed(){
  myFrame.mousePressed();
}


void mouseReleased(){
  myFrame.mouseReleased();
}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
     
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
    //outline frame boundary
    fill (255, 100, 100, 100);
    //noFill();
    stroke(0);
    rectMode(CORNER);
    rect(u0, v0, w, h);
    
  }
  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
