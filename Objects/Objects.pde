interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable{
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing implements Collideable {
  PImage rockP; 
  int pic; 
  float major = random(20)+30;
  float minor = major - random(20)+30;
  Rock(float x, float y, PImage pic1, PImage pic2) {
    super(x, y);
    int r = (int)random(2); 
    if (r == 0) { 
      rockP = pic1; 
      pic = 1; 
    }
    else { 
      rockP = pic2; 
      pic = 2; 
    }
  }
  
  void display(){ 
    image (rockP, x,y, major, minor);
  }
  
  float distance (float x1, float y1, float x2, float y2) { 
    return (sqrt ( pow ((x2 - x1),2) + pow ((y2 - y1), 2))); 
  }
  
  boolean isTouching(Thing other){
    return this.x == other.x || this.y == other.y ;
  }
}

public class LivingRock extends Rock implements Moveable, Collideable {
  float xspeed, yspeed;
  boolean up = true; 
  int counter = 30;
  int counter2 = 200;
  int path = (int)random(3)+1; 
  int sides = 1; 
  LivingRock(float x, float y, PImage pic1, PImage pic2) {
    super(x, y, pic1, pic2);
    xspeed = random(15);
    yspeed = random(15); 
  }
  
  void display () { 
    super.display ();
    if (pic == 1) { //gray rock
      eye (x + 14, y + 15); 
      eye (x + 26, y + 15); 
    }    
    else { //red rock
      eye (x + 14, y + 25); 
      eye (x + 26, y + 25); 
    }
  }
  
  void eye (float xcor, float ycor) { 
    fill (255); 
    ellipse (xcor, ycor, 10, 10); 
    fill (0); 
    ellipse (xcor, ycor, 5, 5);  
  }
  
  void move() {
    if (x + xspeed > 1000 || x + xspeed < 0){  
      xspeed = xspeed*-1; 
    }
    if (y + yspeed > 800 || y + yspeed < 0) {
      yspeed = yspeed*-1; 
    }
    x += xspeed; 
    y += yspeed; 
  }
  void moveSteps() {
    if (counter == 0) {
      counter = 30; 
      up = !up; 
    }
    if (up) {
      if (y + yspeed > 800 || y + yspeed < 0) {
        yspeed = yspeed*-1; 
      }
      y += yspeed;
      counter--; 
    }
    else{
      if (x + xspeed > 1000 || x + xspeed < 0) {
        xspeed = xspeed*-1; 
      }
      x += xspeed;
      counter--;  
    }
  }
  void moveRect(){
    float s = random(10); 
    if (counter == 0) {
      counter = 30; 
      if (sides == 4) {
        sides = 1;
      }
      else {
        sides += 1; 
      }
    }
    if (sides == 1) {
      if (y - s < 0) {
        counter = 0; 
      }
      else {
        y -= s;
        counter--;
      }
    }
    else if (sides == 2) {
      if (x-s < 0) {
        counter = 0; 
      }
      else {
        x -= s;
        counter--; 
      }
    }
    else if (sides == 3) {
      if (y+s > 800) {
        counter = 0;
      }
      else {
        y += s; 
        counter--;
      }
    }
    else {
      if (x+s > 1000) {
        counter = 0; 
      } 
      else {
        x += s; 
        counter--;
      }
    }
  }
  void moveRandom() {
    if (counter2 == 0) {
      counter2 = 200; 
      path = (int)random(3)+1; 
    }
    if (path == 1) {
      move(); 
      counter2--; 
    }
    else if (path == 2) {
      moveSteps(); 
      counter2--;
    }
    else {
      moveRect();
      counter2--;
    }
  }
}

class Ball extends Thing implements Moveable {
  float radius; 
  PImage pic;
  float c = random(256);
  float o = random(256);
  float l = random(256);
  float dX, dY;
  Ball (float x, float y) { 
    super (x, y); 
    radius = random (15);
    dX = random(5);
    dY = random(5);
  }
  Ball(float x, float y, float r) {
    super(x, y);
    radius = r; 
    dX = random(5);
    dY = random(5);
  }
  void display() {
    fill (c, o, l); 
    ellipse (x,y, radius, radius); 
  }
  void move() {
    if (x+dX > 0 && x+dX < width-radius) {
      x += dX; 
    }else{
      dX *= -1;
    }
    if (y+dY > 0 && y+dY < height-radius) {
      y += dY; 
    }else{
      dY *= -1;
    }
  }
  
  void changeC(){
    fill(255,0,0); //red
    ellipse(x,y,radius,radius);
  }
}

class colorChangingBall extends Ball { 
  colorChangingBall(float x, float y){
    super(x,y);
  }
}

class Basketball extends Ball{
  PImage pic;
  float dX;
  float dY;
  int radius;
  
  Basketball(float x, float y, PImage ballP){
    super(x,y);
    pic = ballP;
    dX = random(10);
    dY = random(10);
    radius = (int)random(30)+20;
    pic.resize(radius,radius);
  }
  
  void display(){
    image(pic,x,y);
  }
  
  void move(){
    super.move();
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;

void setup() {
  size(1000, 800);
  PImage Pic1 = loadImage("rock.png"); 
  PImage Pic2 = loadImage ("otherrock.png"); 
  PImage ballP = loadImage ("ball.png");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100),25);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Basketball bb = new Basketball(50+random(width-100), 50+random(height-100),ballP);
    thingsToDisplay.add(bb);
    thingsToMove.add(bb);
    Rock r = new Rock(50+random(width-100), 50+random(height-100), Pic1, Pic2);
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  for (int i = 0; i < 30; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), Pic1, Pic2);
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListOfCollideables.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  /*
  fill(255,125,25);
  ellipse(200,400,50,50);*/
  Ball b = new Ball(200,400);
  
  for ( Collideable c : ListOfCollideables){
    if(c.isTouching(b)){
      b.changeC();
    }
  }
}
