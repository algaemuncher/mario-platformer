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

boolean leftKey, rightKey, upKey, downKey, spaceKey, shootKey, zKey;

float dialoguetrigger = 0;
float zoom = 1.5;
PImage map;
PImage bossmap;
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
PImage[] bowser;

PImage[] idle;
PImage[] run;
PImage[] jump;
PImage[] action;

boolean bossfight = false;
boolean dialogue;
int dialoguecharacter = 0;
PFont mono;

PImage ice;
PImage brick;
PImage dirt, dirtE, dirtN, dirtNE, dirtNW, dirtS, dirtSE, dirtSW, dirtW;

void setup() {
  size(600, 600);
  background(white);

  mono = createFont("SpaceMono-Regular.ttf", 30);

  ice = loadImage("images/blueBlock.png");
  ice.resize(gridSize, gridSize);
  brick = loadImage("images/brick.png");
  brick.resize(gridSize, gridSize);

  dirt = loadImage("images/dirt_center.png");
  dirt.resize(gridSize, gridSize);
  dirtE = loadImage("images/dirt_e.png");
  dirtE.resize(gridSize, gridSize);
  dirtN = loadImage("images/dirt_n.png");
  dirtN.resize(gridSize, gridSize);
  dirtNE = loadImage("images/dirt_ne.png");
  dirtNE.resize(gridSize, gridSize);
  dirtNW = loadImage("images/dirt_nw.png");
  dirtNW.resize(gridSize, gridSize);
  dirtS = loadImage("images/dirt_s.png");
  dirtS.resize(gridSize, gridSize);
  dirtSE = loadImage("images/dirt_se.png");
  dirtSE.resize(gridSize, gridSize);
  dirtSW = loadImage("images/dirt_sw.png");
  dirtSW.resize(gridSize, gridSize);
  dirtW = loadImage("images/dirt_w.png");
  dirtW.resize(gridSize, gridSize);

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
  hmmr.resize(gridSize-5, gridSize-5);

  bowser = new PImage[2];
  //bowser[0] = loadImage("enemies/");
  //bowser[0].resize(gridSize*2,gridSize*2);
  //bowser[1] = loadImage("enemies/");
  //bowser[1].resize(gridSize*2,gridSize*2);

  everything = new ArrayList<FBody>();
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  Fisica.init(this);
  map = loadImage("map2.png");
  bossmap = loadImage("map3.png");
  loadWorld(map);
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
  dialogue();
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

  if (player.getX()<1040&& player.getY()<240 && player.getX() > 408 && player.getY() > 24&& bossfight ==false) {
    loadWorld(bossmap);
    dialoguetrigger = 1;
    bossfight = true;
    player.setPosition(800, 500);
  }
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 600);


  for (int y=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++) {
      color c = img.get(x, y);
      color s = img.get(x, y+1);
      color w = img.get(x-1, y);
      color e = img.get(x+1, y);
      color n = img.get(x, y-1);

      if (c==black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFriction(3);
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
        b.attachImage(brick);
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
        b.attachImage(ice);
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
      if (c == color(163, 73, 164)) {
        Bowser f = new Bowser(x*gridSize, y*gridSize);
        enemies.add(f);
        world.add(f);
      }
    }
  }
  loadPlayer();
}

void resetWorld() {
  enemies.clear();
  terrain.clear();
  world.clear();
  if (bossfight == false) {
    loadWorld(map);
  } else if (bossfight == true) {
    loadWorld(bossmap);
  }
}

void dialogue() {
  if (dialoguetrigger == 1) {
    textEngine("Gotten past my minions you have (Press Z)");
  } else if (dialoguetrigger == 2) {
    textEngine("I am the last that     remains");
  } else if (dialoguetrigger == 3) {
    textEngine("Mario.");
  } else if (dialoguetrigger == 4) {
    textEngine("*zoom out for dramatic effect");
    zoom = 1;
  } else if (dialoguetrigger == 5) {
    textEngine("Did you think about the Goombas?");
    zoom = 1.5;
  } else if (dialoguetrigger == 6) {
    textEngine("The Thwomps?");
    zoom = 2;
  } else if (dialoguetrigger == 7) {
    textEngine("The Hammerbros?");
    zoom = 2.5;
  } else if (dialoguetrigger == 8) {
    textEngine("I will take over the   world!");
  } else if (dialoguetrigger == 9) {
    textEngine("(press F to shoot the  gun)");
  } else if (dialoguetrigger == 10) {
    zoom = 1;
    dialoguetrigger = 0;
  }
}

void textEngine(String t) {
  String impressed = t;
  textFont(mono);
  strokeWeight(2);
  stroke(255);
  fill(0);
  rect(50, 400, 500, 150);
  fill(255, 0, 0);

  for (int i = 0; i<dialoguecharacter; i++) {
    if (75+i*20>=965) {
      text(impressed.charAt(i), i*20 - 385, 520);
    } else if (75+i*20>=525) {
      text(impressed.charAt(i), i*20 - 385, 485);
    } else {
      text(impressed.charAt(i), 75 + i *20, 450);
    }
  }

  if (dialoguecharacter<impressed.length()) {
    //if (75+dialoguecharacter*20>=965) {
    //  text(impressed.charAt(dialoguecharacter), dialoguecharacter*20 - 400, 520);
    //} else if (75+dialoguecharacter*20>=525) {
    //  text(impressed.charAt(dialoguecharacter), dialoguecharacter*20 - 400, 485);
    //} else {
    //  text(impressed.charAt(dialoguecharacter), 75 + dialoguecharacter *20, 450);
    //}
    dialoguecharacter+=1;
  }

  if (zKey&&dialoguecharacter==impressed.length()) {
    dialoguetrigger+=1;
    dialoguecharacter=0;
  }
}
