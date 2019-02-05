import java.util.Arrays;
import java.util.List;

Table myTable = null;
Frame myFrame = null;
ScatterPlot scatter = null;
Axis yAxis = null;
String xCol, yCol;


void setup(){
  size(800,600);  
  selectInput("Select a file to process:", "fileSelected");
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    
    xCol = myTable.getColumnTitles()[2];
    yCol = myTable.getColumnTitles()[3];
    
    
    scatter = new ScatterPlot(myTable, xCol, yCol);
    scatter.setPosition( 100, 0, width - 100, height - 100);
    scatter.setupPointList(); 
    
    yAxis = new Axis(myTable, yCol);
    
    // TODO: create object
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( scatter != null ){
       

     scatter.draw();
  }
  
  if( yAxis != null ){
       
     yAxis.setPosition( 0, 0, 100, height - 100);
     yAxis.yAxis();
     yAxis.drawDistributed();
     yAxis.draw();
  }
}


void mousePressed(){
  //myFrame.mousePressed();
  scatter.setXCol(myTable.getColumnTitles()[2]);
  scatter.setYCol(myTable.getColumnTitles()[3]);
  //scatter.setupPointList();
}


void mouseReleased(){
  //myFrame.mouseReleased();
  scatter.setXCol(myTable.getColumnTitles()[0]);
  scatter.setYCol(myTable.getColumnTitles()[1]);
  //scatter.setupPointList();
}



abstract class Frame {
  
  int u0,v0,w,h;
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
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }
  
  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
