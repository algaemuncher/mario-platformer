class FSign extends FGameObject {
  
  float signtrigger=0;
  String text;
  boolean trigger =false;

  FSign(float x, float y,String t) {
    super();
    setName("sign");
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setFriction(3);
    setFillColor(brown);
    text = t;
  }

  void act() {
    //touch to see text, walk away to unsee text
    if (zKey){
      trigger = true;
    }
    
    if (checkCollision("player")&&trigger ==true){
      textEngine(text,true);
    } else {
      trigger = false;
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
