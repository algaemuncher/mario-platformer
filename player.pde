class FPlayer extends FGameObject {

  int frame;
  int direction;
  int bulletcooldown;
  float burst = 0;
  float holdsecond=0;

  FPlayer(float x, float y) {
    //ice cant be jumped on
    super();
    frame = 0;
    direction = R;
    setName("player");
    setRestitution(0);
    setRotatable(false);
    setPosition(x, y);
    if (dialoguetrigger>0||bossfight==true)setPosition(800, 500);
    setFillColor(color(0, 152, 255));
  }

  void act() {
    if (dialoguetrigger==0) {
      input();
      if (checkCollision("terrain")||checkCollision("bridge")||checkCollision("wall")||checkCollision("thwomp")||checkCollision("checkpoint")) {
        float vx = getVelocityX();
        if (upKey) {
          setVelocity(vx, -500);
          action = jump;
        }
      } else if (checkCollision("trampoline")) {
        float vx = getVelocityX();
        if (upKey) {
          setVelocity(vx, -1000);
          action = jump;
        }
      }
      if (checkCollision("leaves")) {
        float vx = getVelocityX();
        float vy = getVelocityY();
        if (upKey && vy < 0.1 && vy > -0.1) {
          setVelocity(vx, -500);
          action = jump;
        }
      }

      if (checkCollision("spike")) {
        setPosition(100, 460);
        resetWorld();
      }

      animate();
    } else {
      attachImage(reverseImage(action[frame]));
    }
  }

  void input() {
    bulletcooldown--;
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (vy==0) {
      action = idle;
    }
    if (leftKey) {
      setVelocity(-175, vy);
      if (action == jump) {
      } else {
        action = run;
        direction = L;
      }
    }
    if (rightKey) {
      setVelocity(175, vy);
      if (action == jump) {
      } else {
        action = run;
        direction = R;
      }
    }
    //if (upKey) setVelocity(vx, -500);
    if (action == jump && checkCollision("thwomp") == false && checkCollision("bridge")==false&&checkCollision("terrain")==false&& checkCollision("ice")==false&&checkCollision("leaves")==false&&checkCollision("trampoline")==false) {
      if (downKey) setVelocity(vx, 500);
    }

    if (vy>20)action = jump;
    
    //burst
    //if (shootKey&&bulletcooldown<=0&&holdsecond<=0) {
    //  holdsecond+=1;
    //} else if (holdsecond>0) {
    //  burst = round(holdsecond/5);
    //  holdsecond-=1;
    //}

    if (shootKey&&bossfight==true&&dialoguetrigger==0&&bulletcooldown<=0) {
      Bullet shot = new Bullet();
      enemies.add(shot);
      world.add(shot);
      bulletcooldown=10;
    }

    //if (checkCollision("terrains")) setPosition(0,0);
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frame >= idle.length && action == idle) frame = 0;
    if (frameCount % 5 == 0 && action != idle) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    } else if (frameCount % 15 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }


  //  void checkCollision () {
  //    ArrayList<FContact> contacts = getContacts();
  //    for (int i = 0; i< contacts.size(); i++) {
  //      FContact obj = contacts.get(i);
  //      if (obj.contains("ice")) {
  //        float vx = getVelocityX();
  //        if (upKey) setVelocity(vx, -500);

  //      }

  //      if (obj.contains("terrain")) {
  //        float vx = getVelocityX();
  //        if (upKey) setVelocity(vx, -500);

  //      }
  //    }
  //  }
}
