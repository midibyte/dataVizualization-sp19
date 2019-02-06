import java.util.Arrays;
import java.util.List;

Table myTable = null;

ArrayList<ScatterPlot> scatterPlots = null;
ArrayList<Axis> xAxes = null;
ArrayList<Axis> xLegend = null;
ArrayList<Axis> yAxes = null;

int X_AXIS = 1;
int Y_AXIS = 2;
int c1, c2;

//spacing between each plot
float spacing = 10;

Text title = null;

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
    
    //y axis labels
    for (int y = 0; y < myTable.getColumnCount(); y++){
     
      Axis temp = new Axis(myTable, myTable.getColumnTitles()[y]);
      
      float cellHeight = (( height - 100) / myTable.getColumnCount() ) - spacing;
      
      temp.setPosition(  0 , 50 + (y * cellHeight) + (y * spacing ) , 50, cellHeight);
      temp.yAxis();
      
      
      yAxes.add(temp);
    }
   
    xAxes = new ArrayList<Axis>();
    xLegend = new ArrayList<Axis>();
    
    colorMode(HSB, 360, 100, 100);
    c1 = color(50, 100, 100);
    c2 = color(0, 100, 100);
    colorMode(RGB, 255, 255, 255);
    
    //x axis labels
    for (int x = 0; x < myTable.getColumnCount(); x++){
     
      Axis temp = new Axis(myTable, myTable.getColumnTitles()[x]);
      Axis legend = new Axis(myTable, myTable.getColumnTitles()[x]);
      
      float cellWidth = ( (width - 100) / myTable.getColumnCount() ) - spacing;
      
      temp.setPosition(  50 + (x * cellWidth) + (spacing * x) , height - 50, cellWidth, 50);
      
      legend.setPosition(  50 + (x * cellWidth) + (spacing * x) , height - 50, cellWidth, 4);
      
      xAxes.add(temp);
      xLegend.add(legend);
    }    
    
  
    
    for (int y = 0; y < myTable.getColumnCount(); y++){
      for (int x = 0; x < myTable.getColumnCount(); x++){
        
        //total size of all scatter plots
        float w = width - 100;
        float h = height - 100;
        

 
        //float gaps = myTable.getColumnCount() - 1;
        //size of each plot
        float cellWidth = ( w / myTable.getColumnCount() ) - spacing;
        float cellHeight = ( h / myTable.getColumnCount() ) - spacing;
        
        ScatterPlot temp = new ScatterPlot( myTable, myTable.getColumnTitles()[x], myTable.getColumnTitles()[y]);
        temp.setPosition( 50 + (x * cellWidth) + ( spacing * x ), 50 + (y * cellHeight)  + ( spacing * y ), cellWidth, cellHeight );
        temp.setupPointList();
        
        temp.setColorsX();
        
        scatterPlots.add( temp );
        
        
        
      }
    }
    
    title = new Text(selection.getName(), 0);
    title.setPosition(0, 0, width, 50);
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
  
  if (xLegend != null){
   
    for (Axis Ax: xLegend) { Ax.drawGradient(c1, c2, X_AXIS); }
    
  }  

  if (xAxes != null){
   
    for (Axis Ax: xAxes) {Ax.drawDistributedX(3); Ax.draw(); }
    
  }
  
  
  if (yAxes != null){
   
    for (Axis Ax: yAxes) {Ax.draw(); Ax.drawDistributedY(3); }
    
  }
  
  if (title != null){
   
    title.draw();
    
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
  int titleFontSize = 24;
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
