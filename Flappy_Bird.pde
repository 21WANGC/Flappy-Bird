
/* @pjs preload="bg.jpg"; */
/* @pjs preload="flappy.png"; */

import java.util.*;
import java.io.*;

int myY = 281;
int gravity = 5;

int bar1l;
int bar1X = 500;
int bar2l;
int bar2X = 800;

int score = 0;

Scanner scan = new Scanner(System.in);

BufferedReader reader;
PrintWriter writer;
int highscore;

void setup(){
  size(500,600);
  
  reader = createReader("highscore.txt");  
  try{
    String hs = reader.readLine();
    highscore = Integer.parseInt(hs);
  }catch(Exception e){
    System.out.println("Reader Error" + "\n" + e);
  }
  
  System.out.println(highscore);
}

void draw(){  
  PImage bg = loadImage("bg.jpg");
  background(bg);
    
  PImage flappy = loadImage ("flappy.png");
  myY += gravity;
  gravity *= 1.16;
  //System.out.println(myY);
  image(flappy,50,myY,75,75);
  
  //System.out.println(bar1X,myY);
  
  Random bars = new Random();
  //first bar
  if(bar1X == 500){
    bar1l = 1 + bars.nextInt(450);
    //System.out.println(bar1l);
  }
  else if(bar1X >= 10 && bar1X <= 110){
    if(myY <= bar1l-15 || myY >= bar1l+100){
      updateHighscore();
      gg();
    }
  }
  else if(bar1X == -75) bar1X = 505;
  fill(0,255,0);
  rect(bar1X,0,75,bar1l);
  rect(bar1X,bar1l+150,75,500);
  bar1X -= 5;
  
  //second bar
  if(bar2X == 500){
    bar2l = 1 + bars.nextInt(400);
    //System.out.println(bar2l);
  }
  else if(bar2X >= 10 && bar2X <= 110){
    if(myY <= bar2l-15 || myY >= bar2l+100){
      updateHighscore();
      gg();
    }
  }
  else if(bar2X == -75) bar2X = 505;  
  fill(0,255,0);
  rect(bar2X,0,75,bar2l);
  rect(bar2X,bar2l+150,75,500-bar2l);
  bar2X -= 5;
  
  textSize(25);
  fill(0,0,255);
  text(score,250,30);
  fill(255,0,0);
  text("Highscore: " + highscore,10,30);
  
  if(myY > 600){
    updateHighscore();
    gg();
  }
  
  if((bar1X==50) || (bar2X==50)) score++;
}

void keyPressed(){
  gravity = 5;
  myY -= 50;
}

void gg(){
  textSize(25);
  fill(255,0,0);
  text("Game Over",190,100);
  //text("Press R to Restart",150,150);
  noLoop();
  //System.out.print(bar1X + "," + bar2X + "," + myY);
}

void updateHighscore(){
  if(score > highscore){
        writer = createWriter("highscore.txt");
        writer.println(score);
        writer.close();
   }
}