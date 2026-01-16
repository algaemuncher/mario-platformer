class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super();
    setName("bridge");
    setPosition(x, y);
    setStatic(true);
    setFriction(3);
    setRestitution(0.25);
  }

  void act() {
    if (checkCollision("player")){
      setStatic(false);
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
