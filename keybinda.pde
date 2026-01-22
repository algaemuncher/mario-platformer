void keyPressed() {
  if (keyCode == LEFT) leftKey = true;
  if (keyCode == UP) upKey = true;
  if (keyCode == RIGHT) rightKey = true;
  if (keyCode == DOWN) downKey = true;
  if (key == ' ') spaceKey = true;
  if (key == 'f') shootKey = true;
  if (key == 'z') zKey = true;
}

void keyReleased() {
  if (keyCode == LEFT) leftKey = false;
  if (keyCode == UP) upKey = false;
  if (keyCode == RIGHT) rightKey = false;
  if (keyCode == DOWN) downKey = false;
  if (key == ' ') spaceKey = false;
  if (key == 'f') shootKey = false;
    if (key == 'z') zKey = false;
}

void mouseReleased(){
  if (mode == intro)mode = game;
}
