import fisica.*;
FWorld world;


color blue = color(0, 162, 232);
color black = color(0);
color white = color(255);
color brown = color(185, 122, 87);
color yellow = color(255, 242, 0);
color gray = color(127, 127, 127);
color orange = color(255, 127, 39);
color darkbrown = color(136, 0, 21);
color lime = color(181, 230, 29);
color red = color(237, 28, 36);
color lightgrey = color(195, 195, 195);
color pink = color(255, 174, 201);
color green= color(34, 177, 76);

boolean leftKey, rightKey, upKey, downKey, spaceKey, teleportKey;

float zoom = 1.5;
PImage map;
int gridSize = 24;
FPlayer player;

ArrayList<FBody> everything;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

PImage hmmr;
PImage[] hammerbro;
PImage[] thwomp;
PImage[] goomba;
PImage[] lava;

PImage[] idle;
PImage[] run;
PImage[] jump;
PImage[] action;

void setup() {
  size(600, 600);
  background(white);

  idle = new PImage[2];
  idle[0] = loadImage("imageReverser/idle0.png");
  idle[0].resize(gridSize, gridSize);
  idle[1] = loadImage("imageReverser/idle1.png");
  idle[1].resize(gridSize, gridSize);
  run = new PImage[3];
  run[0] = loadImage("imageReverser/runright0.png");
  run[0].resize(gridSize, gridSize);
  run[1] = loadImage("imageReverser/runright1.png");
  run[1].resize(gridSize, gridSize);
  run[2] = loadImage("imageReverser/runright2.png");
  run[2].resize(gridSize, gridSize);
  jump = new PImage[1];
  jump[0] = loadImage("imageReverser/jump0.png");
  jump[0].resize(gridSize, gridSize);
  //jump[1] = loadImage("imageReverser/jump1.png");
  //jump[1].resize(gridSize, gridSize);

  action = idle;

  lava = new PImage[6];
  lava[0] = loadImage("images/lava0.png");
  lava[1] = loadImage("images/lava1.png");
  lava[2] = loadImage("images/lava2.png");
  lava[3] = loadImage("images/lava3.png");
  lava[4] = loadImage("images/lava4.png");
  lava[5] = loadImage("images/lava5.png");
  for (int i = 0; i<lava.length; i++) {
    lava[i].resize(gridSize, gridSize);
  }
  goomba = new PImage[2];
  goomba[0] = loadImage("enemies/goomba0.png");
  goomba[1] = loadImage("enemies/goomba1.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1].resize(gridSize, gridSize);

  thwomp = new PImage[2];
  thwomp[0] = loadImage("enemies/thwomp0.png");
  thwomp[0].resize(2*gridSize, 2*gridSize);
  thwomp[1] = loadImage("enemies/thwomp1.png");
  thwomp[1].resize(2*gridSize, 2*gridSize);

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("enemies/hammerbro0.png");
  hammerbro[0].resize(gridSize, gridSize);
  hammerbro[1] = loadImage("enemies/hammerbro1.png");
  hammerbro[1].resize(gridSize, gridSize);
  hmmr = loadImage("enemies/hammer.png");
  hmmr.resize(gridSize-5,gridSize-5);

  everything = new ArrayList<FBody>();
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  Fisica.init(this);
  map = loadImage("map2.png");
  loadWorld(map);
  loadPlayer();
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  drawWorld();
  player.act();
  actWorld();
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom + width/2, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
  fill(0);
  textSize(50);
  text(player.getX()+" "+player.getY(), 100, 100);
}

void actWorld() {
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject b = terrain.get(i);
    b.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject b = enemies.get(i);
    b.act();
  }
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 600);

  for (int y=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++) {
      color c = img.get(x, y);
      if (c==black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(3);
        b.setFillColor(black);
        b.setStatic(true);
        b.setName("terrain");
        everything.add(b);
        world.add(b);
      }

      if (c==lightgrey) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(3);
        b.setFillColor(lightgrey);
        b.setStatic(true);
        b.setName("wall");
        everything.add(b);
        world.add(b);
      }

      if (c==blue) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(0);
        b.setFillColor(blue);
        b.setName("ice");
        b.setStatic(true);
        everything.add(b);
        world.add(b);
      }

      if (c==brown) {
        FBridge b = new FBridge(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(3);
        b.setFillColor(brown);
        b.setName("bridge");
        world.add(b);
        everything.add(b);
        terrain.add(b);
      }

      if (c==yellow) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(2);
        b.setFillColor(yellow);
        b.setStatic(true);
        b.setName("trampoline");
        everything.add(b);
        world.add(b);
      }

      if (c==gray) {
        FPoly b = new FPoly();
        b.vertex(gridSize/2, gridSize/2);
        b.vertex(gridSize*1.5, gridSize/2);
        b.vertex(gridSize, -gridSize/2);

        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(1);
        b.setFillColor(gray);
        b.setStatic(true);
        b.setName("spike");
        everything.add(b);
        world.add(b);
      }

      if (c==orange) {
        FLava b = new FLava(gridSize, gridSize/2);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(1);
        b.setFillColor(orange);
        b.setStatic(true);
        b.setName("lava");
        world.add(b);
        everything.add(b);
        terrain.add(b);
      }

      if (c==darkbrown) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(1);
        b.setFillColor(color(72, 45, 30));
        b.setStatic(true);
        b.setSensor(true);
        b.setName("stump");
        everything.add(b);
        world.add(b);
      }

      if (c==lime) {
        FLeaf b = new FLeaf(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(1);
        b.setFillColor(lime);
        b.setStatic(true);
        b.setName("leaves");
        everything.add(b);
        terrain.add(b);
        world.add(b);
      }

      if (c==red) {
        FGoomba b = new FGoomba(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setName("goomba");
        everything.add(b);
        enemies.add(b);
        world.add(b);
      }

      if (c==pink) {
        FThwomp b = new FThwomp(gridSize*x, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setName("thwomp");
        everything.add(b);
        enemies.add(b);
        world.add(b);
      }

      if (c==green) {
        FHammerBro b = new FHammerBro(gridSize*x, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setName("hammerbro");
        everything.add(b);
        enemies.add(b);
        world.add(b);
      }
    }
  }
}

void resetWorld() {
  enemies.clear();
  terrain.clear();
  world.clear();
  loadWorld(map);
  loadPlayer();
}
