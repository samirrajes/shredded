float noiseScale = 0.01;
  
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  colorMode(RGB);
  fullScreen();
  //size(1000,1000);
  background(0);
  smooth();
  strokeWeight(0.1);
  
  for(int i = 0; i < 1000; i++){
    particles.add(new Particle(random(width), random(height)));
  }
}

void draw() {
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.outOfBounds()) {
      particles.remove(i);
    }
  }
  
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    for (int j = 0; j < particles.size(); j++) {
      // Check and draw lines to other particles
      Particle otherP = particles.get(j);
      p.checkAndDrawLines(otherP);
    }
  }
}

class Particle {
  PVector pos;
  PVector vel;
  float noiseVal;
  float radius;
  
  Particle(float x, float y) {
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    radius = random(1,10);
  }
  
  void update(){
    if ((pos.x > 0 && pos.x < width) || (pos.y > 0 && pos.y < height)) {
      noiseVal = noise(pos.x * noiseScale,pos.y * noiseScale);
      vel = PVector.fromAngle(noiseVal * TWO_PI);
      vel.setMag(15);
      pos.add(PVector.div(vel,frameRate));
      //display();
    }
  }
  
  void display(){
    circle(pos.x, pos.y, 0);
  }
  
  void checkAndDrawLines(Particle other) {
    float d = PVector.dist(this.pos, other.pos);
    float overlapVal = d / 30;
    if (overlapVal <= 1) {
        stroke(map(overlapVal, 0, 1, 220, 30)); // Varying opacity
        line(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
    }
  }
  
  boolean outOfBounds() {
    return pos.x<0 || pos.y<0 || pos.x>=width || pos.y>=height;
  }
}

void keyPressed() {
  if (keyCode == ENTER)
    saveFrame("shredded####.png");
    
   if (keyCode == 'k' || keyCode == 'K')
     noLoop();
     
   if (keyCode == 'l' || keyCode == 'L')
     loop();
}
