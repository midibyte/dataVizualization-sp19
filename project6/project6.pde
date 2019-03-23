import java.util.Arrays;
import java.util.List;
import java.util.Comparator;
import java.util.Collections;
import java.util.Set;
import java.util.HashSet;

//used to sort points by x coord with custom comparator
public class PointCompare implements Comparator<Point> {
 
  @Override
  public int compare(Point p1, Point p2) {
    //return p1.x.compareTo(p2.x); 
    return Float.compare(p1.x, p2.x);
  }
  
}


int X_AXIS = 1;
int Y_AXIS = 2;
int state = 1;
int c1, c2;


//Objects
Table myTable = null;
//plots
ScatterPlot scatter = null;
ParallelCoordinatesPlot PCP = null;
Barchart bChart = null;

Axis legend = null;
Text title = null;
Text popup = null;
Text subtitle = null;

String xCol, yCol;

float displayFractionWidth, displayFractionHeight, titleHeight, xAxisH, xAxisW, yAxisH, yAxisW;;
float plotH, plotW;

void setup(){
  
  titleHeight = 100;
  
  plotH = height - titleHeight;
  plotW = (width / 5);
  
  size(1200, 700);  
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
    
    //set hue range from c1 to c2 to use to show x value increasing as color gets more red
    colorMode(HSB, 360, 100, 100);
    c1 = color(50, 100, 100);
    c2 = color(0, 100, 100);
    c1 = color(230, 15, 100);
    c2 = color(230, 100, 100);
    colorMode(RGB, 255, 255, 255);
    
    //columns to use on x and y axes
    xCol = myTable.getColumnTitles()[0];
    yCol = myTable.getColumnTitles()[1];
  
    //chart title
    title = new Text(selection.getName(), 0);
    title.setPosition( 0, 0, width, titleHeight );
  
    
    //setup PCP
    PCP = new ParallelCoordinatesPlot(myTable);
    PCP.setPosition( 0, titleHeight, plotW * 2, plotH );
    PCP.setupAxes();
    PCP.setupLines();
    

    //setup scatter plot
    scatter = new ScatterPlot(myTable, xCol, yCol);
    scatter.setPosition( plotW * 2, titleHeight, plotW, plotH / 2);
    //sets up point positions relative to position set with setPosition()
    scatter.setupPointList();
    //sets up colors with hue from 50 to 0 based on x value
    scatter.setColorsX();
    
    //setup barchart
    
    Table sortedTable = loadTable( selection.getAbsolutePath(), "header" );
    
    sortedTable.sort(xCol);
    
    bChart = new Barchart( myTable, yCol, xCol );
    bChart.setPosition( plotW * 2, titleHeight + (plotH/2), plotW, plotH/2);
    bChart.setupPointList(); 
    bChart.setupBars();
  }
  
  
  
  
  loop();
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
  

  if ( popup != null ){
    popup.draw();
  }


  if ( PCP != null ){
    PCP.draw();
  }

  if ( bChart != null ){
    bChart.draw();
  }

}


void mousePressed(){
  
}


void mouseReleased(){
  
}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 9;
  int axisTitleFontSize = 16;
  int titleFontSize = 20;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 3;

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
