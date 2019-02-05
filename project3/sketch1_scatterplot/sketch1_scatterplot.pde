import java.util.Arrays;
import java.util.List;

Table myTable = null;
Frame myFrame = null;
ScatterPlot scatter = null;
Axis yAxis = null;
Axis xAxis = null;
String xCol, yCol;
int state = 0;


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
    
    xCol = myTable.getColumnTitles()[0];
    yCol = myTable.getColumnTitles()[1];
    
    
    scatter = new ScatterPlot(myTable, xCol, yCol);
    scatter.setPosition( 100, 100, width - 200, height - 200);
    scatter.setupPointList(); 
    
    yAxis = new Axis(myTable, yCol);
    xAxis = new Axis(myTable, xCol);
    
    // TODO: create object
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( scatter != null ){
       

     scatter.draw();
     scatter.drawBorder();
  }
  
  if( yAxis != null ){
       
     yAxis.setPosition( 0, 100, 100, height - 200);
     yAxis.yAxis();
     yAxis.drawDistributedY(6);
     yAxis.draw();
  }

  if( xAxis != null ){
       
     xAxis.setPosition( 100, 500, 600, 100);
     xAxis.drawDistributedX(6);
     //xAxis.drawDistributed();
     xAxis.draw();
  }
}

void keyPressed(){
  
  
  if (state == 0){
    state = 1;
    scatter.setXCol(myTable.getColumnTitles()[2]);
    scatter.setYCol(myTable.getColumnTitles()[3]);
    xAxis.setCol(myTable.getColumnTitles()[2]);
    yAxis.setCol(myTable.getColumnTitles()[3]);
  }
  else{
    state = 0;
    scatter.setXCol(myTable.getColumnTitles()[0]);
    scatter.setYCol(myTable.getColumnTitles()[1]);
    xAxis.setCol(myTable.getColumnTitles()[0]);
    yAxis.setCol(myTable.getColumnTitles()[1]);
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
  int axisFontSize = 11;
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
