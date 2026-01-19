class Bowser extends FGameObject {

  StringList attackOrder;
  boolean fallen = false;

  int direction = L;
  int attackNum = 0;
  boolean finished = false;

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
    attackOrder.append("burst");
    
  }

  void act() {
    animate();
    collide();
    move();
    attack();
  }

  void collide() {

    if (checkCollision("player")) {
      if (player.getY() < getY()- gridSize/2) {
      } else {
        player.setPosition(100, 460);
        resetWorld();
      }
    }
  }

  void animate() {
    if (frame >= bowser.length) frame = 0;
    if (frameCount % 10 == 0) {
      //if (player.getX()>=getX()) attachImage(bowser[frame]);
      //else if (player.getX()<getX()) attachImage(reverseImage(bowser[frame]));

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
  
  void attack(){
    if (attackOrder.get(attackNum) == "jump"){
      float vx = getVelocityX();
      setVelocity(vx,-250);
      finished=true;
    } else if(attackOrder.get(attackNum) == "hammers"){
      throwH();
      if (hammersthrown <=0) finished=true;
    } else if(attackOrder.get(attackNum) == "fire"){
      finished = true;
    } else if(attackOrder.get(attackNum) == "thwomps"){
      summonThwomp();
      finished = true;
    } else if(attackOrder.get(attackNum) == "dash"){
      
    } else if(attackOrder.get(attackNum) == "burst"){
      
    }
    
    if (finished == true){
      attackNum += 1;
      finished = false;
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
  
  void summonThwomp(){
    FThwomp t1 = new FThwomp(player.getX(),0,true);
    enemies.add(t1);
    world.add(t1);
  }

  void jump() {
    float vx = getVelocityX();
    int r=int(random(100));
    if (r == 19&&checkCollision("anything")) {
      setVelocity(vx, -300);
    }
  }
}
