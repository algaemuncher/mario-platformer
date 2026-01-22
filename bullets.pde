class Bullet extends FGameObject {

  int direction = 1;

  final int L = 1;
  final int R = -1;
  float opacity = 255;

  Bullet() {
    super();
    setHeight(gridSize/3);
    setWidth(gridSize/3);
    setName("bullet");
    setPosition(player.getX(), player.getY());
    direction = player.direction;
    setNoStroke();
    setFillColor(white);
    setSensor(true);
  }

  void act() {
    move();
    collision();
  }

  void move() {
    opacity-=5;
    setImageAlpha(opacity);
    if (direction == L) {
      setVelocity(-500, -10);
    } else if (direction == R) {
      setVelocity(500, -10);
    }
  }

  void collision() {
    if (checkCollision("bowser")) {
      health -= 10;

      enemies.remove(this);
      world.remove(this);
    }
  }
}
