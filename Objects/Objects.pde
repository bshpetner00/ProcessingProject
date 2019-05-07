interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }
  
  void display(){
    fill(random(256),random(256),random(256));
    ellipse(x, y, (int)random(20)+10,(int)random(20)+10);
    PImage rockP = loadImage("rock.jpg");
    image(rockP,0,0);
  }
}

public class LivingRock extends Rock implements Moveable {
  float xspeed, yspeed; 
  LivingRock(float x, float y) {
    super(x, y);
    xspeed = random(5);
    yspeed = random(5); 
  }
  void move() {
    if (x + xspeed > 600 || x + xspeed < 0){  
      xspeed = xspeed*-1; 
    }
    if (y + yspeed > 600 || y + yspeed < 0) {
      yspeed = yspeed*-1; 
    }
    x += xspeed; 
    y += yspeed; 
  }
}

class Ball extends Thing implements Moveable {
  float radius; 
  PImage ballpic; 
  Ball (float x, float y) { 
    super (x, y); 
    radius = random (15);
    ballpic = loadImage ("ball.png"); 
  }
  Ball(float x, float y, float r) {
    super(x, y);
    radius = r;
  }

  void display() {
    ellipse (x, y, radius, radius);
    fill (255, 100, 103); 
    ellipse (x,y, radius, radius); 
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
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
}
