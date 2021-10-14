boolean debug = true;
PVector position, target;
PImage bg, sitting, laying, stretchin, petting, shook, face;
float margin = 60;


boolean isshook = false;
int shookMarktime = 0;
int shookTimeout = 4000;
float shookSpread = 4;

boolean islaying = false;
int layingMarktime = 0;
int layingTimeout = 4000;
int layingduration = 250;

boolean isstretchin = false;
int stretchinMarktime = 0;
int stretchinTimeout = 2000;
int stretchinDuration = 250;

float distance = 150;
float distance2 = 10;
float movementspeed = 0.08;

void setup() { 
  size(800, 600, P2D);
  
  position = new PVector(width/2, height/2);

  
  imageMode (CENTER);
  sitting = loadImage ("sitting.png");
  sitting.resize (sitting.width/2, sitting.height/2);
  laying = loadImage ("laying.png");
  laying.resize (laying.width/2, laying.height/2);
  stretchin = loadImage ("stretching.png");
  stretchin.resize (stretchin.width/2, stretchin.height/2);
  petting = loadImage ("petting.png");
  petting.resize (petting.width/2, petting.height/2);
  face = sitting;
  shook = loadImage ("shook.png");
  shook.resize (shook.width/2, shook.height/2);
  
  face = sitting;
  
}

void draw() {
  background (254, 176, 98);
  
  PVector mousePos = new PVector(mouseX, mouseY);
  isshook = position.dist(mousePos) < distance;
  
  if (isshook) {
    shookMarktime = millis(); 
    sitting = shook; // shook expression
     position = position.lerp(target, movementspeed).add(new PVector(random(-shookSpread, shookSpread), random(-shookSpread, shookSpread)));
    if (position.dist(target) < distance2) {

     
    }
  } else if (!isshook && millis() > shookMarktime + shookTimeout) {
    if (!islaying && millis() > layingMarktime + layingTimeout) {
    islaying = true;
    layingMarktime = millis();
    } else if (islaying && millis() > layingMarktime + layingTimeout) {
      islaying = false;
    } if (!isstretchin && millis() > stretchinMarktime + stretchinTimeout) {
      islaying = true;
    }
  
  if (islaying) {
    face =  laying; // laying down
  } else {
    face = stretchin; // stretching 
  }
  } else if (!isshook && millis() > shookMarktime + shookTimeout/6) {
    face = sitting; // the normal/neutral position
  }
  position.y += sin(millis()) / 2;
  image (face, position.x, position.y);
  
 
   target = new PVector(random(margin, width-margin), random(margin, height-margin));
 }
  
