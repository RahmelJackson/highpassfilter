int[] tData = new int[500]; //empty array of 500
int[] vData = new int[500];
int[] pData = new int[500];
int minT;
int minV;
int maxT;
int maxV;
PFont font;
int animate = 0; //animation variable

void setup(){
  size(800, 800);
  font = createFont("Arial", 32);
  textFont(font);
    int i;
  int period = 50; //period of square wave = 1/freq
  for (i = 0; i < tData.length; i++){
    tData[i] = i;
   if (i % period < period/2){ //first half of square wave
      vData[i] = 100;
   }else{ //second half
      vData[i] = -100;
    }
  }

  minT = min(tData);
  maxT = max(tData);
  minV = min(vData);
  maxV = max(vData);
}

void draw(){
  background(#ffffbe);
  strokeWeight(6); //size of points
  processData();
  drawAxes();
  animate = (animate + 1) % tData.length;

}
void processData(){
   //filter Data
           int i; //loop variable
  float alpha = .1; //related to time (set arbitarily right now)
  int yprev = pData[0]; //previous value of processed Data, start at 0
  
  for (i = 1; i < animate; i++){
    pData[i] = yprev + int((alpha)*float(vData[i] - yprev)); //filter
yprev = pData[i]; //update previous value
}


}


void drawAxes(){ //draw axes here:
  stroke(#AACCAA);
  int margin= 5; int xCorner= width /margin;;
  int yCorner= height - (height/margin);
  int xEnd = width - (width/margin);
  line(xCorner, yCorner, xEnd, yCorner);
  int yTop = height/margin;
  line(xCorner, yTop, xCorner, yCorner);
  drawLabel(xCorner, yCorner, xEnd, yTop);
  drawPoints(xCorner, yCorner, xEnd, yTop);
}
void drawLabel(int xC, int yC, int xE, int yT){
  fill(#F70207); //red
  text(minT, xC, yC + (30)); //x min location
  text(maxT, xE, yC + (30));
  text(maxV, xC + (-74), yT + (0));
  text(minV, xC + (-60), yC + (-2));
}
void drawPoints(int xC, int yC, int xE, int yT){
  //draw points here...
  int V;
  int T;
  int P;
  int i;
  for (i = 0; i < animate; i = i + 1){
    T = tData[i];
    V = vData[i];
    stroke(#AACCAA); //color for V data
    drawEachPoint(T,V,xC,yC,xE,yT);
    P = pData[i]; //get processed data 
    stroke(#BB00AA); //color for p Data
    drawEachPoint(T, P, xC, yC, xE, yT);

  }
}
void drawEachPoint(int t, int v, int xC, int yC, int xE, int yT){
  float xPoint = map(t, minT, maxT, xC, xE);
  float yPoint = map(v, minV, maxV, yC, yT);
  fill(#005AB2);
  point(xPoint, yPoint);
  //text("(" + str(t) + "," + str(v) + ")", xPoint, yPoint);
}