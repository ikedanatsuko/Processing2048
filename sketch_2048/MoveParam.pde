class MoveParam {
  boolean move;
  int level;
  float posX, posY;
  float goalX, goalY;
  float speedX, speedY;

  MoveParam() {
  }

  MoveParam(int boxX, int boxY, int boxGoalX, int boxGoalY, int levelIn) {
    level = levelIn;
    // Get speed
    speedX = (boxGoalX - boxX) * boxWidth / MOVE_TIME;
    speedY = (boxGoalY - boxY) * boxHeight / MOVE_TIME;
    // Get current position
    posX = boxWidth * (boxX + 0.5);
    posY = boxHeight * (boxY + 0.5);
    // Convert box goal into position goal
    goalX = boxWidth * (boxGoalX + 0.5);
    goalY = boxHeight * (boxGoalY + 0.5);

    move = (boxX == boxGoalX && boxY == boxGoalY ? false : true);
  }

  void move() {
    if (move) {
      posX += speedX;
      posY += speedY;
      if (posX == goalX && posY == goalY) {
        // When move finish
        phase = Phase.pStatic;
      }
    }
  }

  void display() {
    PImage img;
    imageMode(CENTER);
    img = tileImage[level - 1];
    image(img, posX, posY, boxWidth * TILE_SCALE, boxHeight * TILE_SCALE);
  }
}
