class FCheckpoint extends FGameObject {

  FCheckpoint(float x, float y) {
    super();
    setName("checkpoint");
    setPosition(x, y);
    setStatic(true);
    setFriction(3);
    setFillColor(yellow);
  }

  void act() {
    if (checkCollision("player")){
      checkpointX = getX();
      checkpointY = getY()-gridSize;
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
