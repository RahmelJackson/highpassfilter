int[] x = {4,3,0,-2,-3,-2,-0,1,-0,-2,-4,-3,1,3,3,1,-2,-2,-0,2,1,1,2,5,5,3,-1,-2,1,-1,0,2,-0,-1,-2,-3,-3,0,1,0,-3,-3,-2,5,8,4,12,12,-7,-9,-8,-52,-38,-80,-39,32,23,100,32,14,-18,-28,-9,11,40,75,5,-33,-95,-81,-23,6,88,93,35,-10,-27,-46,-15,-47,-57,-1,-7,48,98,104,17,-43,-84,-18,22,51,67,-43,-53,-89,-53,-2,52,111,57,31,-27,-13,-83,-34,-52,-29,26,45,76,67,55,-18,-56,-55,-1,27,33,-25,-76,-83,-90,-5,-5,87,137,64,16,-5,-37,-65,-14,-70,13,20,-10,78,49,43,19,-36,-63,-15,11,65,-2,-30,-97,-63,-12,10,49,91,43,-38,1,-80,-65,-25,-102,12,47,47,98,87,-1,-57,-63,-5,63,86,43,-51,-36,-77,-66,-25,-4,87,61,74,-31,-30,-94,-55,-14,-18,35,0,41,53,65,54,-15,-42,-29,9,57,74,-25,-8,-69,-25,-27,-13,84,38,6,13,-14,-74,-28,-78,-35,37,46,93,71,30,-57,-64,-55,2,46,62,42,19,-38,-62,-60,-41,-1,82,70,-13,-26,-51,-109,-35,-49,10,25,47,64,76,24,-20,-71,-36,-4,39,81,-18,9,-59,-44,-11,-18,92,56,35,-15,-46,-64,-49,-19,-38,18,45,43,79,74,14,-26,-96,-62,-4,34,76,1,6,-17,-36,-42,-27,67,55,21,-33,-23,-103,-80,-35,15,56,73,72,59,42,-4,-42,-50,-41,-18,20,46,24,-32,-38,-7,-33,29,67,52,14,-71,-72,-90,-17,-50,8,59,65,115,125,53,-0,-93,-74,-20,11,45,-11,15,-25,-35,-37,-35,45,51,40,1,-7,-75,-109,-23,-24,13,54,27,35,52,28,-9,-55,-46,-17,22,65,-7,-31,-57,-29,-53,-14,66,57,30,-38,-32,-68,-33,-34,2,15,22,52,90,60,32,-16,-83,-33,-8,15,31,22,3,-42,4,-38,-19,69,61,29,-1,-26,-93}; //sample audio
float Fs = 4410; float Ts; //sampling frequency
int counter = 0;
int lowPrev = 0;
int highPrev = 0;
int midPrev = 0;
void setup(){
 size(400, 400); 
 Ts = 1.0 / 
}

void draw(){
 background(#FFFFFF);
 lowRect(); //draw visualizers
 midRect();
 highRect();
 counter = (counter + 1) % x.length; //increase the counter (loop the audio)
 strokeWeight(abs(x[counter])); //create time data visualizer
 point(200, 200); //draw point of different sizes based directly on music
 strokeWeight(1); 
 delay(2);
 //println(counter);
}
void lowRect(){
  int y = lowPass(20.0, lowPrev); //filter
  lowPrev = y; //update prev value
  int col = color(abs(y)*2, 0, 0); //set color of rectangle as R G B values
  //println(y);
  fill(col);
  rect(10, 10, 90, 90);
}

void highRect(){
  int y = highPass(1000.0, highPrev);
  highPrev = y;
  int col = color(0, abs(y)*2, 0);
  fill(col);
  rect(210, 10, 90, 90);
}

void midRect(){
  int y = lowPass(1000.0, midPrev);
  y = highPass(20.0, y);
  midPrev = y;
  int col = color(0, 0, abs(y)*2);
  fill(col);
  rect(110, 10, 90, 90);
}
  

int lowPass(float Fc, int yprev){
  float alpha = (Ts) / (Ts + (1.0/Fc));
  //float alpha = .5;
  int yout = x[counter] + int(alpha*float(yprev + x[counter]));
  
  return yout;
}
int highPass(float Fc, int yprev){
  float beta = 1.0 / (1.0 + (2.0*3.1415*Fc*Ts));
  int xprev;
  if (counter == 0){
    xprev = 0;
  }
  else{
    xprev = x[counter - 1];
  }
  int yout = int(beta*float(yprev + x[counter] - xprev));
  return yout;
}
