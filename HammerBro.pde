class FHammerBro extends FGameObject {

  int direction = L;

  int speed = 50;
  int frame = 0;

  FHammerBro(float x, float y) {
    super();
    setName("hammerbro");
    setPosition(x, y);
    setRotatable(false);
    setFriction(3);
  }

  void act() {
    animate();
    collide();
    move();
    jump();
    throwH();
  }

  void collide() {

    if (checkCollision("player")) {
      if (player.getY() < getY()- gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -200);
      } else {
        player.setPosition(100, 460);
        resetWorld();
      }
    }

  }

  void animate() {
    if (frame >= hammerbro.length) frame = 0;
    if (frameCount % 10 == 0) {
      if (direction == L) attachImage(hammerbro[frame]);
      else if (direction == R) attachImage(reverseImage(hammerbro[frame]));

      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
    
    int r = int(random(20, 100));
    if (frameCount % r == 0) {
      direction *= -1;
    }
  }

  void throwH() {
    if (frameCount % 50 == 0) {
      hammer hamer = new hammer(getX(), getY(), 200, -350);
      if (player.getX() >= getX()) {
        hamer.setVelocity(200, -350);
      } else if (player.getX() < getX()) {
        hamer.setVelocity(-200, -350);
      }
      world.add(hamer);
      enemies.add(hamer);
    }
  }

  void jump() {
    float vx = getVelocityX();
    int r=int(random(100));
    if (r == 19&&checkCollision("anything")) {
      setVelocity(vx, -400);
    }
  }
}

class hammer extends FGameObject {

  hammer(float x, float y, float vx, float vy) {
    super();
    setWidth(gridSize/2);
    setHeight(gridSize/2);
    setVelocity(vx, vy);
    setPosition(x, y);
    attachImage(hmmr);
    setSensor(true);
    setName("hammer");
  }

  void act() {
  }
}
