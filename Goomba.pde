class FGoomba extends FGameObject {

  int direction = L;

  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super();
    setName("Goomba");
    setPosition(x, y);
    setRotatable(false);
    setHeight(gridSize-1);
    setFriction(3);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void collide() {
    if (checkCollision("wall")||checkCollision("bridge")||checkCollision("hammerbro")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }
    if (checkCollision("player")) {
      if (player.getY() < getY()- gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -200);
      } else {
        player.setPosition(100,460);
        resetWorld();
      }
    }
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 10 == 0) {
      attachImage(goomba[frame]);
      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
