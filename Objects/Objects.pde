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

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }
  
  void display(){
    fill(0,0,255);
    ellipse(x, y, (int)random(20)+10,(int)random(20)+10);
    
  }
}

public class LivingRock extends Rock implements Moveable {
  float xspeed, yspeed;
  boolean up = true; 
  int counter = 30;
  int counter2 = 200;
  int path = (int)random(3)+1; 
  int sides = 1; 
  LivingRock(float x, float y) {
    super(x, y);
    xspeed = random(5);
    yspeed = random(5); 
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
  PImage ballpic;
  int c,o,l;
  Ball (float x, float y) { 
    super (x, y); 
    radius = random (15);
    ballpic = loadImage ("ball.png");
    float c = random(256);
    float o = random(256);
    float l = random(256);
  }
  Ball(float x, float y, float r) {
    super(x, y);
    radius = r;
    float c = random(256);
    float o = random(256);
    float l = random(256);
  }

  void display() {
    fill (c, o, l); 
    ellipse (x,y, radius, radius); 
  }

  void move() {
    float[][]paths = { {5,0}, {0,5}, {-5,0}, {0,-5}, };
    int i = (int)random(0,4);
    float dX = paths[i][0];
    float dY = paths[i][1];
    if (x+dX > 25 && x+dX < width - 25) {
      x += dX; 
    } 
    if (y+dY > 25 && y+dY < height - 25) {
      y += dY; 
    }
  }
}

class colorChangingBall extends Ball { 
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100),25);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
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
}