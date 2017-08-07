class PlayArea {
  float areaWidth, areaHeight;
  TileManager tileManager;
  PlayAreaDisplay playAreaDisplay;
  MoveAnimation moveAnimation = new MoveAnimation();

  PlayArea(int tileSize) {
    areaWidth = width;
    areaHeight = height;
    tileManager = new TileManager(tileSize);
    playAreaDisplay = new PlayAreaDisplay();
  }

  PlayArea(int tileSize, float areaWidth, float areaHeight) {
    this.areaWidth = areaWidth;
    this.areaHeight = areaHeight;
    tileManager = new TileManager(tileSize);
    playAreaDisplay = new PlayAreaDisplay();
  }

  void display() {
    switch (phase) {
      case pStatic:
        playAreaDisplay.bg();
        playAreaDisplay.tiles(tileManager.tiles);
        break;
      case pMove:
        playAreaDisplay.bg();
        moveAnimation.display();
        break;
    }
  }

  // Change tile position
  void move(Direction dir) {
    int[][] previousTiles;

    switch (dir) {
    case mUP:
      previousTiles = tileManager.tiles;
      moveAnimation = new MoveAnimation(tileManager.move_tiles_u());
      break;
    case mDOWN:
      previousTiles = tileManager.tiles;
      moveAnimation = new MoveAnimation(tileManager.move_tiles_d());
      break;
    case mRIGHT:
      previousTiles = tileManager.tiles;
      moveAnimation = new MoveAnimation(tileManager.move_tiles_r());
      break;
    case mLEFT:
      previousTiles = tileManager.tiles;
      moveAnimation = new MoveAnimation(tileManager.move_tiles_l());
      break;
    }
  }
}
