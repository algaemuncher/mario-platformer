class FGameObject extends FBox {

  final int L = 1;
  final int R = -1;

  FGameObject() {
    super(gridSize, gridSize);
  }

  void act() {
  }

  boolean checkCollision (String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i< contacts.size(); i++) {
      FContact obj = contacts.get(i);
      if (obj.contains(n)) {
        return true;
      }

      if (n=="anything") {
        for (int j =0; j<everything.size(); j++) {
          if (obj.contains(everything.get(j))&&this!=everything.get(j)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
