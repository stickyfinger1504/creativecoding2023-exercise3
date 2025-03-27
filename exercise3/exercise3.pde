PImage bg, startNormal, startHover, lose, win, restart, ship;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 210;
final int BUTTON_BOTTOM = 280;
final int BUTTON_LEFT = 115;
final int BUTTON_RIGHT = 450;

float shipX, shipY;
float shipSpeed = 5;
float shipWidth = 50;

float wall1Speed = 1;
float wall2Speed = 2;
float wall3Speed = 3;

float wall1Y = 100;
float wall2Y = 200;
float wall3Y = 300;

float wall1HoleWidth = 300;
float wall2HoleWidth = 200;
//I've tested and 100 width for hole 3 is impossible to win so I changed it to 150
float wall3HoleWidth = 150;

float winningLineY = 400;

//first line gap X
float wall1X1;
float wall1X2;

//second line gap X
float wall2X1;
float wall2X2;

//third line gap X
float wall3X1;
float wall3X2;

color wallColor;

void setup() {
  size(600, 500);
  bg=loadImage("img/bg.png");
  startNormal=loadImage("img/start1.png");
  startHover=loadImage("img/start2.png");
  lose=loadImage("img/lose.png");
  win=loadImage("img/win.png");
  restart=loadImage("img/restart.png");
  ship=loadImage("img/ship.png");

  shipX = width / 2 - shipWidth / 2;
  shipY = 0;
  
  //first line gap X
  wall1X1=width/2-wall1HoleWidth/2;
  wall1X2=width/2+wall1HoleWidth/2;

  //second line gap X
  wall2X1=width/2-wall2HoleWidth/2;
  wall2X2=width/2+wall2HoleWidth/2;

  //third line gap X
  wall3X1=width/2-wall3HoleWidth/2;
  wall3X2=width/2+wall3HoleWidth/2;
  
  wallColor = color(247, 210, 60);
}

void draw() {
  switch(gameState){
    case GAME_START:
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHover, 0, 0);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, 0, 0);
      }
    break;
    
    case GAME_RUN:
      image(bg, 0, 0);
      image(ship, shipX, shipY);
      
      // draw walls
      stroke(wallColor);
      strokeWeight(5);
      
      //collision check
        //wall 1
      // Check for collision with the wall
      if (shipY + 50 >= wall1Y && shipY <= wall1Y + 5) {
        if ((shipX + shipWidth > 0 && shipX < wall1X1) || (shipX + shipWidth > wall1X2 && shipX < width)) {
          // Ship has collided with the wall (not in the hole)
          gameState = GAME_LOSE;
        }
      }
      else if (shipY + 50 >= wall2Y && shipY <= wall2Y + 5) {
        if ((shipX + shipWidth > 0 && shipX < wall2X1) || (shipX + shipWidth > wall2X2 && shipX < width)) {
   
          gameState = GAME_LOSE;
        }
      }
      else if (shipY + 50 >= wall3Y && shipY <= wall3Y + 5) { 
        if ((shipX + shipWidth > 0 && shipX < wall3X1) || (shipX + shipWidth > wall3X2 && shipX < width)) {

          gameState = GAME_LOSE;
        }
      }
      
      //move the hole
        //hole 1
      wall1X1+=wall1Speed;
      wall1X2+=wall1Speed;
      
      if(wall1X1>=width-wall1HoleWidth || wall1X1 <0){
      wall1Speed= -wall1Speed;
      }
      
      line(0,wall1Y,wall1X1,wall1Y);
      line(wall1X2,wall1Y,width,wall1Y);
      
         //hole 2
      wall2X1+=wall2Speed;
      wall2X2+=wall2Speed;
      
      if(wall2X1>=width-wall2HoleWidth || wall2X1 <0){
      wall2Speed= -wall2Speed;
      }
      
      line(0,wall2Y,wall2X1,wall2Y);
      line(wall2X2,wall2Y,width,wall2Y);
      
         //hole 3
      wall3X1+=wall3Speed;
      wall3X2+=wall3Speed;
      
      if(wall3X1>=width-wall3HoleWidth || wall3X1 <0){
      wall3Speed= -wall3Speed;
      }
      
      line(0,wall3Y,wall3X1,wall3Y);
      line(wall3X2,wall3Y,width,wall3Y);
    
    
    //win condition
     if(shipY+shipWidth>=winningLineY){
      gameState=GAME_WIN;
    }
      break;
     
    case GAME_WIN:
      image(win, 0, 0);
      break;
      
    case GAME_LOSE:
      image(lose, 0, 0);
      break;
  }
}

void keyPressed(){
  // DO NOT REMOVE THIS PART!!!
  // USED FOR DEBUGGING
  switch (key){
    case '1':
      gameState = GAME_START;
      break;
    case '2':
      gameState = GAME_RUN;
      break;
    case '3':
      gameState = GAME_WIN;
      break;
    case '4':
      gameState = GAME_LOSE;
      break;
  }
  // Your code start from here
  
  if(key==ENTER){
    resetGame();
  }
  
  //Moving the spaceship
  if (keyCode==UP || keyCode=='w' || keyCode=='W'){
    shipY-=shipSpeed;
  }
  else if(keyCode==DOWN || keyCode=='s'|| keyCode=='S'){
    shipY+=shipSpeed;
  }
  else if(keyCode==LEFT||keyCode=='a'|| keyCode=='A'){
   shipX-=shipSpeed;
  }
  else if(keyCode==RIGHT || keyCode=='d'|| keyCode=='D'){
   shipX+=shipSpeed; 
  }
}

void resetGame() {
  // Reset game state to start
  gameState = GAME_START;

  // Reset ship position
  shipX = width / 2 - shipWidth / 2;
  shipY = 0;

  // Reset wall positions
  wall1X1 = width / 2 - wall1HoleWidth / 2;
  wall1X2 = width / 2 + wall1HoleWidth / 2;
  wall2X1 = width / 2 - wall2HoleWidth / 2;
  wall2X2 = width / 2 + wall2HoleWidth / 2;
  wall3X1 = width / 2 - wall3HoleWidth / 2;
  wall3X2 = width / 2 + wall3HoleWidth / 2;

  // Reset wall speeds
  wall1Speed = 1;
  wall2Speed = 2;
  wall3Speed = 3;

  // Reset wall Y positions
  wall1Y = 100;
  wall2Y = 200;
  wall3Y = 300;

  // Reset winning line position
  winningLineY = 400;

  // Reset wall hole widths
  wall1HoleWidth = 300;
  wall2HoleWidth = 200;
  wall3HoleWidth = 100;

  // Reset wall color (optional)
  wallColor = color(247, 210, 60);
}

void keyReleased(){

}
