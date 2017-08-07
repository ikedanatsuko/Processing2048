class PlayArea {
  float areaWidth, areaHeight;
  TileManager tileManager;
  // PlayAreaDisplay playAreaDisplay = new PlayAreaDisplay();
  PlayAreaDisplay playAreaDisplay;

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

  // void init() {
  //   tileManager.init_tiles();
  // }

  void display() {
    playAreaDisplay.bg();
    playAreaDisplay.tiles(tileManager.tiles);
  }

  void displayBg() {
    playAreaDisplay.bg();
  }

  // Change tile position
  void move(Direction dir) {
    int[][] previousTiles;

    switch (dir) {
    case mUP:
      previousTiles = tileManager.tiles;
      // tileManager.move_tiles_u();
      moveAnimation = new MoveAnimation(tileManager.move_tiles_u());
      // phase = Phase.pMove;
      break;
    case mDOWN:
      previousTiles = tileManager.tiles;
      // tileManager.move_tiles_d();
      moveAnimation = new MoveAnimation(tileManager.move_tiles_d());
      // phase = Phase.pMove;
      break;
    case mRIGHT:
      previousTiles = tileManager.tiles;
      // tileManager.move_tiles_r();
      moveAnimation = new MoveAnimation(tileManager.move_tiles_r());
      // phase = Phase.pMove;
      break;
    case mLEFT:
      previousTiles = tileManager.tiles;
      // tileManager.move_tiles_l();
      moveAnimation = new MoveAnimation(tileManager.move_tiles_l());
      // phase = Phase.pMove;
      break;
    }
  }
}
