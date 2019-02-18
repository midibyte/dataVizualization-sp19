import java.util.Arrays;
import java.util.List;
import java.util.Collections;
import java.util.Set;
import java.util.HashSet;

Table myTable = null;
Barchart chart = null;
Text title = null;
Text legend = null;
Axis x_axis = null;
Axis y_axis = null;
float displayFractionWidth, displayFractionHeight;
String xLabelCol, displayDataCol, nameCol;

//get input file
void setup(){
  size(1000,700);
  //fractions to determine placement of frames
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
    nameCol = myTable.getColumnTitles()[3];
    
    chart = new Barchart( myTable, displayDataCol );
    chart.setPosition( displayFractionWidth, displayFractionHeight, displayFractionWidth * 6, displayFractionHeight * 6);
    //creates the point list used to place the labels
    chart.setupPointList();  
    //set colors for bars
    chart.setColorsFromNames(nameCol);
    
    //set title from file name
    title = new Text (selection.getName(), 0);
    title.setPosition( 0, 0, displayFractionWidth * 8, displayFractionHeight );
    
    legend = new Text(myTable.getColumnTitles()[3].trim(), chart.getUniqueNamesList(), 0);
    legend.setPosition( displayFractionWidth * 7, displayFractionHeight, displayFractionWidth, displayFractionHeight * 6 );
    legend.setTextColors( chart.getColorsList() );
    
    y_axis = new Axis( myTable, displayDataCol );
    y_axis.setPosition( 0, displayFractionHeight, displayFractionWidth, displayFractionHeight * 6);
    y_axis.yAxis();
    
    x_axis = new Axis( myTable, xLabelCol );
    x_axis.setPosition( displayFractionWidth, displayFractionHeight * 7, displayFractionWidth * 6, displayFractionHeight);
    //set to x axis for text
    x_axis.xAxis();
    
    
    //set positions
    
    
    
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( chart != null ){

       
       
       //draws the bars
       chart.draw();
       //draw after to get labels on top, requires point list
       chart.labelsBelowPoints();

  }
  
  if ( title != null ){
    
    
    
    title.draw();
  }
  
  if ( legend != null ){
    
    
    legend.draw();
  }
  
  if ( y_axis != null ){
    
    
    y_axis.draw();
  }
  if ( x_axis != null ){
    
    
    x_axis.draw();
  }
}


void mousePressed(){
  chart.mousePressed();
}


void mouseReleased(){
  chart.mouseReleased();
}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 14;
  int axisTitleFontSize = 16;
  int titleFontSize = 32;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 16;
  
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
  
  void printCurrentPosition(){
   
    println( String.format( "u0:%f v0:%f w:%f h:%f", u0, v0, w, h ) );
    
  }
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }
  
  void highlightFrame() {
    
    //draw a rectagle to highlight the frame to confirm its position
    fill (255, 100, 100, 100);
    stroke(0);
    rectMode(CORNER);
    rect(u0, v0, w, h);
    
  }
  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
