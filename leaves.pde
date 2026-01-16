class FLeaf extends FGameObject {

  int frame = 0;

  FLeaf(float x, float y) {
    super();
    setName("leaves");
    setPosition(x, y);
    setStatic(true);
    setFriction(3);
  }

  void act() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      //if (direction == R) attachImage(action[frame]);
      //if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
    if (player.getVelocityY() >-0.1 || checkCollision("thwomp")) {
      setSensor(false);
    } else {
      setSensor(true);
    }
  }



  //void checkCollision () {
  //  ArrayList<FContact> contacts = getContacts();
  //  for (int i = 0; i< contacts.size(); i++) {
  //    FContact obj = contacts.get(i);
  //    if (obj.contains("ice")) {
  //    }
  //  }
  //}
}
