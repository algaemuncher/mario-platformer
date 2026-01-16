class FThwomp extends FGameObject {

  int mode = 1;
  final int rest = 1;
  final int fall = 2;
  final int pause = 3;
  final int rise = 4;

  int pauseCooldown=0;
  int frame = 0;
  float targetX;

  FThwomp(float x, float y) {
    super();
    setName("thwomp");
    setPosition(x, y);
    setRotatable(false);
    setWidth(gridSize*2);
    setHeight(gridSize*2);
    targetX = x;
  }

  void act() {
    move();
    animate();
    collide();
  }

  void collide() {
    if (checkCollision("terrain") && mode == rise) {
      mode = rest;
    } else if (checkCollision("terrain") && mode == fall) {
      mode = pause;
    } else if (checkCollision("leaves") && mode == fall) {
      mode = pause;
    } else if (player.getY()>getY() && player.getX() > getX()-gridSize && player.getX() < getX()+gridSize && mode == rest) {
      mode = fall;
    } else if (pauseCooldown > 35) {
      mode = rise;
      pauseCooldown = 0;
    } else if (mode == pause) {
      pauseCooldown+=1;
    }

    if (checkCollision("player")&& player.getY()> getY()+gridSize && mode == fall) {
      setPosition(100, 460);
      resetWorld();
    }

    if (checkCollision("player")&& player.getY()< getY()-gridSize && mode == rise && player.checkCollision("terrain") ==true) {
      setPosition(100, 460);
      resetWorld();
    }
  }

  void animate() {
    if (mode == rest) {
      attachImage(thwomp[0]);
    } else if (mode == fall) {
      attachImage(thwomp[1]);
    } else if (mode == pause) {
      attachImage(thwomp[0]);
    } else if (mode == rise) {
      attachImage(thwomp[0]);
    }
  }

  void move() {
    if (mode == rest) {
      setStatic(true);
    } else if (mode == fall) {
      setStatic(false);
    } else if (mode == pause) {
      setStatic(true);
    } else if (mode == rise) {
      setStatic(false);
      setVelocity(0, -75);
    }

    if (getX() != targetX) setPosition(targetX, getY());
  }
}
