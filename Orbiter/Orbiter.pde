ArrayList<Body> Planets= new ArrayList<Body>(); //<>//
Body CURRENT;
ArrayList<Ship> Ships = new ArrayList<Ship>();
HashMap<Character, Boolean> Keys = new HashMap<Character, Boolean>();

void setup() {
    fullScreen();
  
    this.Keys.put('a', false);
    this.Keys.put('d', false);
    this.Keys.put('w', false);
  
    Transforms.push(new Transform());
    OrbitState origin = new OrbitState(new PVector(0, 0), new PVector());
    Orbit center = new Orbit(origin);
    Body planetOriginus = new Body(center, 750);
    this.Planets.add(planetOriginus);
  
    for (int i = 0; i < 0; i++) {
      OrbitState moonOrbitStart = new OrbitState(new PVector(random(-1500.0, 1500.0), random(-1500.0, 1500.0)), new PVector(random(-.8, .8), random(-.8, .8)));
      Orbit moonOrbit = new Orbit(moonOrbitStart);
      Body moon = new Body(moonOrbit, (int)random(40, 100));
      this.Planets.add(moon);
      moon.fill = color(100);
    }
  
    OrbitState point = new OrbitState(new PVector(1, 0), new PVector(0, -0.01));
    Orbit orbit = new Orbit(point);
    PLAYER = new Player(orbit);
    this.Ships.add(PLAYER);
  
    smooth();
    strokeJoin(ROUND);
}

void draw() {
  background(0);
  TUtils.zoomStep();
  PLAYER.EvaluateInputs();
  pushMatrix();
  translate(width/2, height/2);        
  if (mousePressed && Transforms.peek().panEnabled) {
    Transforms.peek().offset.add((pmouseX - mouseX)/TUtils.scale(), (pmouseY - mouseY)/TUtils.scale());
  }
  for (Body body : Planets) {
    body.Draw();
  }
  for (Ship ship : Ships) {
    ship.Draw();
  }
  fill(0, 180, 0);
  popMatrix();
  text(frameRate, 10, 10);
  fill(150);
  rect(8, height - 52, ((float)PLAYER.MaxDeltaV*50) + 4, 24);
  fill(0, 0, 220);
  rect(10, height - 50, (float)PLAYER.DeltaV*50, 20);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e < 0) {
    TUtils.zoomIn();
  } else {
    TUtils.zoomOut();
  }
}

void keyPressed() {
  if (key != CODED) {
    Keys.put(key, true);
  } else {
    Keys.put((char)keyCode, true);
  }
}

void keyReleased() {
  if (key != CODED) {
    Keys.put(key, false);
  } else {
    Keys.put((char)keyCode, false);
  }
}