import java.util.Arrays;
import java.util.List;

int X_AXIS = 1;
int Y_AXIS = 2;
int c1, c2;

//Objects
Table myTable = null;
ScatterPlot scatter = null;
Axis yAxis = null;
Axis xAxis = null;
Axis legend = null;
Text title = null;
Text popup = null;
Text subtitle = null;

String xCol, yCol;
int state = 0;

float displayFractionWidth, displayFractionHeight, titleHeight, xAxisH, xAxisW, yAxisH, yAxisW;;


void setup(){
  size(1000,700);  
  
  titleHeight = 80;
  xAxisH = 50;
  yAxisW = 100;
  xAxisW = width - yAxisW*2;
  yAxisH = height - titleHeight - xAxisH;
  
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
    
    //columns to use on x and y axes
    xCol = myTable.getColumnTitles()[0];
    yCol = myTable.getColumnTitles()[1];
    
    //setup scatter plot
    scatter = new ScatterPlot(myTable, xCol, yCol);
    scatter.setPosition( 100, 100, width - 200, height - 200);
    //sets up point positions relative to position set with setPosition()
    scatter.setupPointList();
    //sets up colors with hue from 50 to 0 based on x value
    scatter.setColorsX();
    
    //axis markings
    yAxis = new Axis(myTable, yCol);
    xAxis = new Axis(myTable, xCol);
    
    //chart title
    title = new Text(selection.getName(), 0);
    title.setPosition( 0, 0, width, titleHeight );
    
    //subtitle
    subtitle = new Text("Press any key to change view", 0);
    subtitle.setPosition(0, titleHeight/3, width, titleHeight);
    subtitle.setTitleSize(16);
    
    //color legebnd for x axis
    //legend = new Axis(myTable, yCol);
    
    //set hue range from c1 to c2 to use to show x value increasing as color gets more red
    colorMode(HSB, 360, 100, 100);
    c1 = color(50, 100, 100);
    c2 = color(0, 100, 100);
    c1 = color(230, 15, 100);
    c2 = color(230, 100, 100);
    colorMode(RGB, 255, 255, 255);
    
    
    loop();
    
  }
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if(legend != null) {
    //set gradient position and colors to use as legend on x axis
    legend.setPosition( 0, 0, width/4, 100 );
    legend.setGradient( 100, height - 100, width - 200, 10, c1, c2, X_AXIS);
    //legend.drawDistributedX(6);
  }
  
  if( scatter != null ){
     scatter.draw();
     //scatter.drawBorder();
  }
  
  if( title != null ){  
     title.draw();  
  }
  if( subtitle != null ){ 
     subtitle.draw();     
  }
  
  if( yAxis != null ){
       
     yAxis.setPosition( 0, 100, 100, height - 200);
     yAxis.yAxis();
     yAxis.drawDistributedY(6);
     yAxis.draw();
  }
  if ( popup != null ){
    popup.draw();
  }
  if( xAxis != null ){
       
     xAxis.setPosition( 100, height - 100, width - 200, 100);
     xAxis.drawDistributedX(6);
     //xAxis.drawDistributed();
     xAxis.draw();
  }
  

}

//switch column to display when any key pressed
void keyPressed(){
  popup = null;
  
  if (state == 0){
    state = 1;
    scatter.setXCol(myTable.getColumnTitles()[2]);
    scatter.setYCol(myTable.getColumnTitles()[3]);
    xAxis.setCol(myTable.getColumnTitles()[2]);
    yAxis.setCol(myTable.getColumnTitles()[3]);
    xCol = myTable.getColumnTitles()[2];
    yCol = myTable.getColumnTitles()[3];
  }
  else{
    state = 0;
    scatter.setXCol(myTable.getColumnTitles()[0]);
    scatter.setYCol(myTable.getColumnTitles()[1]);
    xAxis.setCol(myTable.getColumnTitles()[0]);
    yAxis.setCol(myTable.getColumnTitles()[1]);
    xCol = myTable.getColumnTitles()[0];
    yCol = myTable.getColumnTitles()[1];
  }
 
  
}

void mousePressed(){ 

  if (scatter.getPointList() != null){
    for (Point p: scatter.getPointList()){
      if(p.mouseInside()) {
       
        noLoop();
        String text = String.format("%s, %s: %.2f, %.2f", xCol, yCol, p.datax, p.datay);
        popup = new Text(text, 0);
        popup.setPosition( 0, (titleHeight/3) * 2, width, titleHeight);
        popup.setTitleSize(14);
        loop();
      }
    }
  }
    
} 


void mouseReleased(){

}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 11;
  int axisTitleFontSize = 16;
  int titleFontSize = 24;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 6;
  
  void setTitleSize(int newSize){
    titleFontSize = newSize;
  }
  
  void setPosition( float u0, float v0, float w, float h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
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
