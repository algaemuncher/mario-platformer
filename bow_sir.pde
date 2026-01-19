class Bowser extends FGameObject {

  StringList attackOrder;

  int direction = L;

  int speed = 50;
  int frame = 0;
  int hammercooldown = 0;
  int hammersthrown=0;

  Bowser(float x, float y) {
    super();
    setName("bowser");
    setPosition(x, y);
    setRotatable(false);
    setFriction(3);
    attackOrder = new StringList();
    attackOrder.append("jump");
    attackOrder.append("hammers");
    attackOrder.append("fire");
    attackOrder.append("thwomps");
    attackOrder.append("dash");
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
      if (player.getX()>=getX()) attachImage(hammerbro[frame]);
      else if (player.getX()<getX()) attachImage(reverseImage(hammerbro[frame]));

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
    if (hammercooldown <= 0) {
      hammersthrown = 3;
    }

    if (hammersthrown > 0 && frameCount%5==0) {
      hammer hamer = new hammer(getX(), getY(), 200, -350);
      if (player.getX() >= getX()) {
        hamer.setVelocity(200, -350);
      } else if (player.getX() < getX()) {
        hamer.setVelocity(-200, -350);
      }
      world.add(hamer);
      enemies.add(hamer);
      hammersthrown -= 1;
      hammercooldown = 100;
    }

    if (hammercooldown>0) hammercooldown -= 1;
  }

  void jump() {
    float vx = getVelocityX();
    int r=int(random(100));
    if (r == 19&&checkCollision("anything")) {
      setVelocity(vx, -200);
    }
  }
}
