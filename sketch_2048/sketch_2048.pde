// あとアニメーションつけたらプレイエリアは完成
// 実行：control + alt + b

final int TILE_SIZE = 4;
final float TILE_SCALE = 0.8;
final int LEVEL_SIZE = 6;
final int MOVE_TIME = 10; // Size of frame required for movement

Phase phase = Phase.pStatic; // Initial state

float boxWidth, boxHeight;
PImage[] tileImage;

PlayArea playArea;

void setup() {
  tileImage = new PImage[] {
    loadImage("tile/white.png"),
    loadImage("tile/blue.png"),
    loadImage("tile/green.png"),
    loadImage("tile/yellow.png"),
    loadImage("tile/pink.png"),
    loadImage("tile/red.png")
  };

  size(300, 300);
  boxWidth = width / TILE_SIZE;
  boxHeight = height / TILE_SIZE;
  playArea = new PlayArea(TILE_SIZE, width, height);
}

void draw() {
  playArea.display();
}

void keyPressed() {
  if (keyCode == UP) {
    playArea.move(Direction.mUP);
  }
  if (keyCode == DOWN) {
    playArea.move(Direction.mDOWN);
  }
  if (keyCode == RIGHT) {
    playArea.move(Direction.mRIGHT);
  }
  if (keyCode == LEFT) {
    playArea.move(Direction.mLEFT);
  }
}
