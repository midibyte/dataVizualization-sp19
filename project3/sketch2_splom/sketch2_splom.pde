import java.util.Arrays;
import java.util.List;

Table myTable = null;

ArrayList<ScatterPlot> scatterPlots = null;
ArrayList<Axis> xAxes = null;
ArrayList<Axis> yAxes = null;

void setup(){
  size(800,600);  
  selectInput("Select a file to process:", "fileSelected");
}


void fileSelected(File selection) {
  noLoop();
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    // TODO: create object
    
    scatterPlots = new ArrayList<ScatterPlot>();
    yAxes = new ArrayList<Axis>();
    
    for (int y = 0; y < myTable.getColumnCount(); y++){
     
      Axis temp = new Axis(myTable, myTable.getColumnTitles()[y]);
      
      float cellHeight = height / myTable.getColumnCount();
      
      temp.setPosition(  0 , y * cellHeight, 100, cellHeight);
      temp.yAxis();
      temp.drawDistributedY(4);
      
      yAxes.add(temp);
    }
   
    xAxes = new ArrayList<Axis>();
    
    for (int x = 0; x < myTable.getColumnCount(); x++){
     
      Axis temp = new Axis(myTable, myTable.getColumnTitles()[x]);
      
      float cellWidth = width / myTable.getColumnCount();
      
      temp.setPosition(  x * cellWidth , height - 100, cellWidth, 100);
      
      temp.drawDistributedX(4);
      
      xAxes.add(temp);
    }    
    
  
    
    for (int y = 0; y < myTable.getColumnCount(); y++){
      for (int x = 0; x < myTable.getColumnCount(); x++){
        
        float w = width - 100;
        float h = height - 100;
        
        float cellWidth = w / myTable.getColumnCount();
        float cellHeight = h / myTable.getColumnCount();
        
        ScatterPlot temp = new ScatterPlot( myTable, myTable.getColumnTitles()[x], myTable.getColumnTitles()[y]);
        temp.setPosition( 100 + (x * cellWidth), (y * cellHeight), cellWidth, cellHeight );
        temp.setupPointList();
        
        scatterPlots.add( temp );
        
        
        
      }
    }
    
    //prevent drawing before arraylist is filled
    loop();
  }
}



void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( scatterPlots != null && scatterPlots.size() == myTable.getColumnCount() * myTable.getColumnCount()){
   
    //
    for (ScatterPlot p: scatterPlots) { p.draw(); p.drawBorder();}
  }
  
  if (xAxes != null){
   
    for (Axis Ax: xAxes) {Ax.draw(); }
    
  }
  
  if (yAxes != null){
   
    for (Axis Ax: yAxes) {Ax.draw(); }
    
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
  int axisFontSize = 6;
  int axisTitleFontSize = 14;
  int titleFontSize = 32;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 3;
     
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
  
  void drawBorder() {
   
    noFill();
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER);
    rect(u0, v0, w, h);
  }
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }

  
  boolean mouseInside(){
     return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
  }
  
  
}
