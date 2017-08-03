class PlayArea {
  float areaWidth, areaHeight;
  TileManager tileManager;
  PlayAreaDisplay playAreaDisplay = new PlayAreaDisplay();

  PlayArea(int tileSize) {
    areaWidth = width;
    areaHeight = height;
    tileManager = new TileManager(tileSize);
  }

  PlayArea(int tileSize, float areaWidth, float areaHeight) {
    this.areaWidth = areaWidth;
    this.areaHeight = areaHeight;
    tileManager = new TileManager(tileSize);
  }

  void init() {
    tileManager.init_tiles();
  }

  void display() {
    playAreaDisplay.draw_bg();
    playAreaDisplay.draw_tiles(tileManager.tiles);
  }

  // Change tile position
  void move(Direction dir, MoveAnimation moveAnimation) {
    switch (dir) {
    case mUP:
      int[][] previousTiles = tileManager.getTiles();
      tileManager.move_tiles_u();
      // phase = Phase.pMove;
      break;
    case mDOWN:
      int[][] previousTiles = tileManager.getTiles();
      tileManager.move_tiles_d();
      // phase = Phase.pMove;
      break;
    case mRIGHT:
      int[][] previousTiles = tileManager.getTiles();
      tileManager.move_tiles_r();
      // phase = Phase.pMove;
      break;
    case mLEFT:
      int[][] previousTiles = tileManager.getTiles();
      tileManager.move_tiles_l();
      // phase = Phase.pMove;
      break;
    }
  }
}
