import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
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
int c1, c2;
int state = 0;

Table myTable = null;
Text title = null;
Text subtitle = null;
Text legend = null;
Text popup = null;
Axis x_axis = null;
Axis y_axis = null;
Linechart chart = null;
float displayFractionWidth, displayFractionHeight, titleHeight, xAxisH, xAxisW, yAxisH, yAxisW;;
String xLabelCol, displayDataCol, pointLabelCol;

//get input file
void setup(){
  size(1000, 700);
  
  
  titleHeight = 80;
  xAxisH = 50;
  yAxisW = 100;
  xAxisW = width - yAxisW*2;
  yAxisH = height - titleHeight - xAxisH;
  
  displayFractionWidth = width/8;
  displayFractionHeight = height/8;
  selectInput("Select a file to process:", "fileSelected");
}

//file open dialog, load into table object, create barchart with Barchart Class
void fileSelected(File selection) {
  noLoop();
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    myTable = loadTable( selection.getAbsolutePath(), "header" );
    
    //set data to display from the table
    xLabelCol = myTable.getColumnTitles()[0];
    displayDataCol = myTable.getColumnTitles()[1];
    pointLabelCol = myTable.getColumnTitles()[3];
    
    //line chart
    chart = new Linechart( myTable, displayDataCol, xLabelCol );
    chart.setPosition( displayFractionWidth, displayFractionHeight, displayFractionWidth * 6, displayFractionHeight * 6);
    //need to set position before setting up points
    chart.setupPointList();
    chart.setColorsFromNames(pointLabelCol);
    
    //set title from file name
    title = new Text (selection.getName(), 0);
    title.setPosition( 0, 0, width, titleHeight );
    
    //subtitle
    subtitle = new Text("Click any point to see value, press any key to change view", 0);
    subtitle.setPosition(0, titleHeight/3, width, titleHeight);
    subtitle.setTitleSize(16);
    
    ////color legend
    //legend.setPosition( displayFractionWidth * 7, displayFractionHeight, displayFractionWidth, displayFractionHeight * 6 );
    //legend = new Text(myTable.getColumnTitles()[3].trim(), chart.getUniqueNamesList(), 0);
    //legend.setTextColors( chart.getColorsList() );
    
    //y axis labels and ticks
    y_axis = new Axis( myTable, displayDataCol );
    y_axis.setPosition( 0, displayFractionHeight, displayFractionWidth, displayFractionHeight * 6);
    y_axis.yAxis();
    
    //x axis labels and ticks
    x_axis = new Axis( myTable, xLabelCol );
    x_axis.setPosition( displayFractionWidth, displayFractionHeight * 7, displayFractionWidth * 6, displayFractionHeight);
    //set to x axis for text
    x_axis.xAxis();

  }
  
  loop();
}


void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  //draw chart
  if( chart != null ){

       //chart.labelsBelowPoints();
       //chart.drawBorder();
       chart.draw();
  }
  
  if ( title != null ){

    title.draw();
  }
  if ( subtitle != null ){

    subtitle.draw();
  }
  if ( popup != null ){
    popup.draw();
  }
  if ( y_axis != null ){
    y_axis.drawDistributedY(3);
    y_axis.draw();
  }
  if ( x_axis != null ){
    x_axis.drawDistributedX(6);
    x_axis.draw();
  }
  
  if ( legend != null ){
    
    
    legend.draw();
  }
  
}

//switch column to display when any key pressed
void keyPressed(){
  
  popup = null;
  
  noLoop();
  if (state == 0){
    state = 1;
    //set data to display from the table
    xLabelCol = myTable.getColumnTitles()[0];
    displayDataCol = myTable.getColumnTitles()[1];
    //nameCol = myTable.getColumnTitles()[3];
  }
  else{
    state = 0;
    //set data to display from the table
    xLabelCol = myTable.getColumnTitles()[2];
    displayDataCol = myTable.getColumnTitles()[3];
    //nameCol = myTable.getColumnTitles()[3];
    
  }
    

    
    //line chart
    chart = new Linechart( myTable, displayDataCol, xLabelCol );
    chart.setPosition( yAxisW, titleHeight, xAxisW, yAxisH);
    //need to set position before setting up points
    chart.setupPointList();
    chart.setColorsFromNames(pointLabelCol);
    
    y_axis = new Axis( myTable, displayDataCol );
    y_axis.setPosition( 0, titleHeight, yAxisW, yAxisH);
    y_axis.yAxis();
    
    x_axis = new Axis( myTable, xLabelCol );
    x_axis.setPosition( yAxisW, titleHeight + yAxisH, xAxisW, xAxisH);
    //set to x axis for text
    x_axis.xAxis();
    
    loop();
  
 
  
}

void mousePressed(){ 

  if (chart.getPointList() != null){
    for (Point p: chart.getPointList()){
      if(p.mouseInside()) {
       
        noLoop();
        String text = String.format("%s, %s: %.2f, %.2f",xLabelCol,displayDataCol, p.origX, p.origY);
        popup = new Text(text, 0);
        popup.setPosition( 0, (titleHeight/3) * 2, width,titleHeight);
        popup.setTitleSize(14);
        loop();
      }
      
    }
}  
  
  
}



void mouseReleased(){
  //chart.mouseReleased();
}



abstract class Frame {
  
  float u0,v0,w,h;
  int clickBuffer = 2;
  //set sizes here
  int axisFontSize = 14;
  int axisTitleFontSize = 16;
  int titleFontSize = 20;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 5;
     
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
