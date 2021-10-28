int gameScreen = 0;
int ballX, ballY;
int ballSize = 20;
int ballColor = color(0);
int racketBounceRate = 20;
int wallSpeed = 5;
int wallInterval = 1000;
int minGapHeight = 200;
int maxGapHeight = 300;
int wallWidth = 80;
int maxHealth = 100;
int healthBarWidth = 60;
int score = 0;


float gravity = 1;
float ballSpeedVert = 0;
float airfriction = 0.0001;
float friction = 0.1;
float ballSpeedHorizon = 10;
float racketWidth = 100;
float racketHeight = 10;
float lastAddTime = 0;
float health = 100;
float healthDecrease = 1;


color racketColor = color(28);
color wallColors = color(28);

ArrayList <int[]> walls = new ArrayList <int[]> (); 



void setup () {
  size (500, 500);
  ballX = width/4;
  ballY = height/5;
}

void draw () {
  if (gameScreen == 0) {
    initScreen ();
  } else if (gameScreen == 1) {
    gameScreen ();
  } else if (gameScreen == 2) {
    gameOverScreen ();
  }
}

void initScreen () {
  background (0);
  textAlign(CENTER);
  text ("Click To Start", height/2, width/2);
}

void gameScreen () {
  background (255);
  drawBall ();
  applyGravity ();
  keepInScreen ();
  drawRacket();
  watchRacketBounce();
  applyHorizontalSpeed ();

  drawHealthBar();
 
}

void gameOverScreen () {
  background (0);
  textAlign (CENTER);
  fill (255);
  textSize (40);
  text ("Game Over", height/2, width/2 - 20);
  textSize (15);
  text ("Click to Restart", height/2, width/2 +10);
}


public void mousePressed() {
  if (gameScreen == 0) {
    startGame ();
      if (gameScreen==2) {
    restart ();
      }
  }
}

void startGame () {
  gameScreen = 1;
}

void drawBall () {
  fill (ballColor);
  ellipse (ballX, ballY, ballSize, ballSize);
}

void applyGravity () {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}

void makeBounceBottom (int surface) {
  ballY = surface - (ballSize/2);
  ballSpeedVert *= -1;
  ballSpeedVert -= (ballSpeedVert * friction);
  
}

void makeBounceTop (int surface) {
  ballSpeedVert -= (ballSpeedVert * friction);
}

void keepInScreen () {
  if (ballY + (ballSize/2) > height) {
    makeBounceBottom (height);
  }
  if (ballY - (ballSize/2) < 0) {
  }
  if (ballX - (ballSize/2) < 0){
    makeBounceLeft (0);
  }
  if (ballX + (ballSize/2) > width) {
    makeBounceRight (width);
  }
}

void drawRacket () {
  fill (racketColor);
  rectMode (CENTER);
  rect (mouseX, mouseY, racketWidth, racketHeight);
}

void watchRacketBounce () {
  float overhead = mouseY - pmouseY;
  if ((ballX + (ballSize/2) > mouseX - (racketWidth/2)) && (ballX - (ballSize/2) < mouseX+ 
  (racketWidth/2))) {
    if (dist(ballX, ballY, ballX, mouseY) <= (ballSize/2)+abs(overhead)) {
      makeBounceBottom (mouseY);
      if (overhead<0) {
        ballY+=overhead;
        ballSpeedVert +=overhead;
      }
    }
  }
}

void applyHorizontalSpeed () {
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}

void makeBounceLeft (int surface) {
  ballX = surface + (ballSize/2);
  ballSpeedHorizon *= -1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}

void makeBounceRight (int surface) {
  ballX = surface - (ballSize/2);
  ballSpeedHorizon *= -1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}

void drawHealthBar (){
  noStroke();
  fill (174, 173, 146);
  rectMode (CORNER);
  rect (ballX - (healthBarWidth/2), ballY - 30, healthBarWidth, 5);
  if (health > 60) {
  fill (165, 150, 130);
  } else if (health > 30) {
    fill (211, 171, 159);
  } else {
    fill (241, 141, 126);
  }
  rectMode (CORNER);
  rect (ballX - (healthBarWidth/2), ballY - 30, healthBarWidth * (health/maxHealth), 5);
}

void decreaseHealth () {
  health -= healthDecrease;
  if (health <= 0) {
    gameOverScreen ();
  }
}

void restart () {
  score = 0;
  health = maxHealth;
  ballX = width/4;
  ballY = height/5;
  lastAddTime = 0;
  walls.clear ();
  gameScreen = 0;
}

void score () {
  score++;
}
