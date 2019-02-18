import java.util.Arrays;
import java.util.List;

Table myTable = null;
Table trimmedTable = null;
//lists to hold each scatter plot cell, legend, and axis markings
ArrayList<ScatterPlot> scatterPlots = null;
ArrayList<Axis> xAxes = null;
ArrayList<Axis> xLegend = null;
ArrayList<Axis> yAxes = null;
ArrayList<Axis> yAxesRight = null;

ScatterPlot popup = null;
Axis popupXAxis = null;
Axis popupYAxis = null;
Text subtitle = null;

int X_AXIS = 1;
int Y_AXIS = 2;
int c1, c2;

//spacing between each plot
float spacing = 20;
//total size of all scatter plots
float splom_w;
float splom_h;

float verticalAxisWidth = 100;
float titleHeight = 50;
float horizontalAxisHeight = 50;

Text title = null;

void setup(){
  size(1000,700);
  splom_w = width - 100;
  splom_h = height - 100;
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
      
      trimmedTable = loadTable( selection.getAbsolutePath(), "header" );
      
      for (int x = 0; x < trimmedTable.getColumnCount(); x++){
       
        if(Float.isNaN(trimmedTable.getFloat(3, myTable.getColumnTitles()[x])) )  
          {
           myTable.removeColumn(myTable.getColumnTitles()[x]);
           println("col: " + x + " is nan");
            
          }

      }
      
      
      scatterPlots = new ArrayList<ScatterPlot>();
      yAxes = new ArrayList<Axis>();
      yAxesRight = new ArrayList<Axis>();
      
      //setup positions and values for y axis labels
      for (int y = 0; y < myTable.getColumnCount(); y++){
       
        Axis temp = new Axis(myTable, myTable.getColumnTitles()[y]);
        Axis tempRight = new Axis(myTable, myTable.getColumnTitles()[y]);
        
        float cellHeight = (splom_h / myTable.getColumnCount() ) - spacing;
        
        //labels start in top left corner
        temp.setPosition(  0 , 50 + (y * cellHeight) + (y * spacing ) , verticalAxisWidth, cellHeight);
        tempRight.setPosition(  (width - 50) , 50 + (y * cellHeight) + (y * spacing ) , 50, cellHeight);
        temp.yAxis();
        tempRight.yAxis();
        
        yAxes.add(temp);      
        yAxesRight.add(tempRight);
      }
     
      //list to hold axes
      xAxes = new ArrayList<Axis>();
      xLegend = new ArrayList<Axis>();
      
      //setup colors to use for points and legend, hue from yellow to red based on increasing x value
      colorMode(HSB, 360, 100, 100);
      c1 = color(50, 100, 100);
      c2 = color(0, 100, 100);
      colorMode(RGB, 255, 255, 255);
      
      //setup positions and values for x axis labels and color legends
      for (int x = 0; x < myTable.getColumnCount(); x++){
       
        //if ( myTable.getColumnType(x) == Table.STRING) continue;
        
        Axis temp = new Axis(myTable, myTable.getColumnTitles()[x]);
        Axis legend = new Axis(myTable, myTable.getColumnTitles()[x]);
        
        float cellWidth = ( splom_w / myTable.getColumnCount() ) - spacing;
        
        temp.setPosition( verticalAxisWidth + (x * cellWidth) + (spacing * x) , height - horizontalAxisHeight, cellWidth, horizontalAxisHeight);   
        legend.setPosition( verticalAxisWidth + (x * cellWidth) + (spacing * x) , height - horizontalAxisHeight, cellWidth, 4);
        
        xAxes.add(temp);
        xLegend.add(legend);
      }    
      
      int displayX = 0;
      //setup each scatter plot cell and add to list for drawing later
      for (int y = 0; y < myTable.getColumnCount(); y++){
        for (int x = 0; x < myTable.getColumnCount(); x++){
          

          //size of each plot
          float cellWidth = ( splom_w / myTable.getColumnCount() ) - spacing;
          float cellHeight = ( splom_h / myTable.getColumnCount() ) - spacing;
          
          //if ( myTable.getColumnType(x) == Table.STRING || myTable.getColumnType(y) == Table.STRING) continue;
          
          ScatterPlot temp = new ScatterPlot( myTable, myTable.getColumnTitles()[x], myTable.getColumnTitles()[y]);
          
          temp.setPosition( verticalAxisWidth + (x * cellWidth) + ( spacing * x ), titleHeight + (y * cellHeight)  + ( spacing * y ), cellWidth, cellHeight );
          temp.setupPointList();   
          temp.setColorsX();
          
          //if(x != 0 && x == y) temp.displayFalse();
          
          if(x > displayX) temp.displayFalse();
          
          
          
          scatterPlots.add( temp );
  
        }
        displayX++;
      }
      
      
      
      title = new Text(selection.getName(), 0);
      title.setPosition(0, 0, width, titleHeight);
      //prevent drawing before arraylist is filled
      
      //subtitle
      subtitle = new Text("Click any point to see value, press any key to change view", 0);
      subtitle.setPosition(0, titleHeight/2, width, titleHeight);
      subtitle.setTitleSize(16);  
      loop();
  }
}


//draw everything using lists setup above
void draw(){
  background( 255 );
  
  if( myTable == null ) 
    return;
  
  if( scatterPlots != null && scatterPlots.size() == myTable.getColumnCount() * myTable.getColumnCount()){
    
      for (ScatterPlot p: scatterPlots) { 
        
        if (p.display) {
          p.draw(); 
          p.drawBorder();
        }

      }
    }
  
  if (xLegend != null){
   
    //for (Axis Ax: xLegend) { Ax.drawGradient(c1, c2, X_AXIS); }
    
  }  

  if (xAxes != null){
   
    for (Axis Ax: xAxes) {Ax.drawDistributedX(3); Ax.draw(); }
    
  }
  
  
  if (yAxes != null){
   
    for (Axis Ax: yAxes) {Ax.draw(); Ax.drawDistributedY(3); }
    
  }
  //if (yAxesRight != null){
   
  //  for (Axis Ax: yAxesRight) {Ax.draw(); Ax.drawAxisTitle();}
    
  //}
  
  if (title != null){
   
    title.draw();
    
  }
  if (subtitle != null){
   
    subtitle.draw();
    
  }
  
  if (popup != null){
   
    //draw clicked frame larger
    popup.draw();
    popup.drawBorder();
  }
  if (popup != null){
   
    //draw clicked frame larger
    popup.draw();
    //popup.drawBorder();
  }
  if (popupXAxis != null){
   
    //draw clicked frame larger
    popup.draw();
    popupXAxis.drawDistributedX(5);
    popupXAxis.drawAxisTitleX();
    //popup.drawBorder();
  }
  
  if (popupYAxis != null){
   
    //draw clicked frame larger
    popup.draw();
    popupYAxis.drawDistributedYNoTitle(4);
    popupYAxis.drawAxisTitle();
    //popup.drawBorder();
  }
  

}


void mousePressed(){

  //check which frame the mouse is inside then copy to larger frame
  //popup = new ScatterPlot();
  
  
  if(scatterPlots != null){
    int count = 0;
    for (ScatterPlot p: scatterPlots){
      
      count++;
      if(p.mouseInside() && p.display == true){
        noLoop();
        
        float popupX, popupY, popupW, popupH, popupAxisXH, popupAxisYH, popupAxisXW, popupAxisYW;
        
        
        popupY = titleHeight;
        popupAxisXH = titleHeight;
        popupAxisYW = 50;
        popupX = splom_w/2 + verticalAxisWidth + popupAxisYW;
        popupW = (splom_w/2) - spacing - popupAxisYW;
        popupH = (splom_h / 2 ) - spacing - popupAxisXH;
        popupAxisYH = popupH;
        popupAxisXW = popupW;
        
        
        popup = new ScatterPlot(p.data, p.useX, p.useY);
        //popup.setPosition( (width/2), titleHeight * 2, (splom_w/2) - spacing, (splom_h/2) - spacing);
        popup.setPosition(popupX, popupY, popupW, popupH);
        popup.setupPointList();   
        popup.setColorsX();
        
        
        println("clicked inside: " + count);
        
        loop();
        
        popupXAxis = new Axis(p.data, p.useX);
        popupXAxis.setPosition(splom_w/2 + verticalAxisWidth + popupAxisYW, titleHeight + popupH, popupAxisXW, popupAxisXH);

        popupYAxis = new Axis(p.data, p.useY);
        //popupYAxis.yAxis();
        popupYAxis.setPosition( splom_w/2 + verticalAxisWidth, titleHeight, popupAxisYW, popupAxisYH );
        break;
      }
      
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
  int axisFontSize = 10;
  int axisTitleFontSize = 14;
  int titleFontSize = 24;
  int subtitleFontSize = 16;
  int pointLabelFontSize = 16;
  int pointSize = 2;
  
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
