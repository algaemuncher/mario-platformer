class FLava extends FGameObject {
  
  int frame = int(random(0,6));

  FLava(float x, float y) {
    super();
    setName("lava");
    setPosition(x, y);
    setHeight(y/2.6);
    setStatic(true);
    setFriction(3);
    
  }

  void act() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(lava[frame]);
      frame++;
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
