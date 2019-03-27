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
Linechart lChart = null;
Splom splom = null;

Axis legend = null;
Text title = null;
Text popup = null;
Text subtitle = null;

int spacingY = 30;
int spacingX = 30;

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
  
    //chart title
    subtitle = new Text("Click in splom to change views, click on points to highlight across views, press c to clear selection", 0);
    subtitle.setPosition( 0, titleHeight/3, width, titleHeight/2 );
    
    //setup PCP
    PCP = new ParallelCoordinatesPlot(myTable);
    // 2/5 width, 1/2 height
    PCP.setPosition( 0 + 50, titleHeight, plotW * 2 - 50, plotH/ 2 );
    PCP.setupAxes();
    PCP.setupLines();
    

    //setup scatter plot
    scatter = new ScatterPlot(myTable, xCol, yCol);
    //below PCP 1/2 height
    //scatter.setPosition( 0, titleHeight + plotH/2 + spacingY, plotW, (plotH/2 )- spacingY*2);
    scatter.setPosition( plotW * 3 + plotW/2, titleHeight + spacingY, plotW + plotW/4, (plotH/2) - spacingY*2);
    //sets up point positions relative to position set with setPosition()
    scatter.setupPointList();
    //sets up colors with hue from 50 to 0 based on x value
    scatter.setColorsX();
    
    //setup barchart   
    bChart = new Barchart( myTable, xCol, yCol );
    //bChart.setPosition( plotW * 4, titleHeight, plotW, plotH/2);
    bChart.setPosition( 0, titleHeight + plotH/2 + spacingY, plotW, (plotH/2 )- spacingY*2);
    bChart.setupPointList(); 
    bChart.setupBars();
    
    
    
    //setup linechart
    lChart = new Linechart( myTable, yCol, xCol );
    //below PCP next to scatter plot
    lChart.setPosition( plotW + spacingX, titleHeight + plotH/2 + spacingY, plotW - spacingX*2, plotH / 2 - spacingY*2);
    lChart.setupPointList();
    
    
    //setup splom
    splom = new Splom(myTable);
    //void setupSplom(float spacing)
    splom.setPosition(plotW * 2, titleHeight, plotW* 3, plotH);
    splom.setupSplom(20);
    
    
    
    
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

  if ( lChart != null ){
    lChart.draw();
  }
  if ( splom != null ){
    splom.draw();
    //splom.highlightFrame();
  }
}

void clearAll(){
  scatter.clearHighlight();
  lChart.clearHighlight();
  PCP.clearHighlight();
  bChart.clearHighlight();
}

void keyPressed(){
  if(key == 'c'){
    
    clearAll();
  }
}

void mousePressed(){

  //check which frame in the splom the mouse is inside then copy to larger frame
  //popup = new ScatterPlot();
  
  ArrayList<ScatterPlot> scatterPlots = null;
  if (splom != null) {scatterPlots = splom.getScatterPlots();}
  
  if(scatterPlots != null){
    int count = 0;
    for (ScatterPlot p: scatterPlots){
      
      count++;
      if(p.mouseInside() && p.display == true){
        clearAll();
        noLoop();
        
        //setup scatter plot
        scatter = new ScatterPlot(myTable, p.useX, p.useY);
        //below PCP 1/2 height
        //scatter.setPosition( 0, titleHeight + plotH/2 + spacingY, plotW, (plotH/2 )- spacingY*2);
        scatter.setPosition( plotW * 3 + plotW/2, titleHeight + spacingY, plotW + plotW/4, (plotH/2) - spacingY*2);
        //sets up point positions relative to position set with setPosition()
        scatter.setupPointList();
        //sets up colors with hue from 50 to 0 based on x value
        scatter.setColorsX();
        
        println("clicked inside: " + count);
        

        //setup barchart   
        bChart = new Barchart( myTable, p.useX, p.useY );
        //bChart.setPosition( plotW * 4, titleHeight, plotW, plotH/2);
        bChart.setPosition( 0, titleHeight + plotH/2 + spacingY, plotW, (plotH/2 )- spacingY*2);
        bChart.setupPointList(); 
        bChart.setupBars();
        
        
        
        //setup linechart
        lChart = new Linechart( myTable, p.useY, p.useX );
        //below PCP next to scatter plot
        lChart.setPosition( plotW + spacingX, titleHeight + plotH/2 + spacingY, plotW - spacingX*2, plotH / 2 - spacingY*2);
        lChart.setupPointList();
        loop();
        break;
      }
      loop();
    }
  }
  
  if(PCP.mouseInside()){
    PCP.mousePressed();
    for(Line l: PCP.highlightedLines){
      for (Float f: l.origYVals){
        scatter.addHighlightFromOrig(f);
        lChart.addHighlightFromOrig(f);
        bChart.addHighlightFromOrig(f);
      }
    }
  }
  
  if (bChart.mouseInside()){
    bChart.mousePressed();
    for (Bar b: bChart.highlightedBars){
      scatter.addHighlightFromOrig(b.origX, b.origY);
      lChart.addHighlightFromOrig(b.origX, b.origY);
      PCP.addHighlightFromOriginal(b.origY);
    }
  }
  if (lChart.mouseInside()){
    lChart.mousePressed();
    for (Point p: lChart.highlightedPoints){
      bChart.addHighlightFromOrig(p.origX, p.origY);
      scatter.addHighlightFromOrig(p.origX, p.origY);
      PCP.addHighlightFromOriginal(p.origY);
    }
  }
  if (scatter.mouseInside()){
    scatter.mousePressed();
    for (Point p: scatter.highlightedPoints){
      bChart.addHighlightFromOrig(p.origX, p.origY);
      lChart.addHighlightFromOrig(p.origX, p.origY);
      PCP.addHighlightFromOriginal(p.origY);
    }
  }

  
}


void mouseReleased(){
  
}



abstract class Frame {
  
  boolean display = true;
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 12;
  int axisTitleFontSize = 16;
  int titleFontSize = 20;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 3;

  void setTitleSize(int newSize){
    titleFontSize = newSize;
  } 

  void displayFalse(){
   
    display = false;
    
  }
  
  void displayTrue(){
   
    display = true;
    
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
