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

  void move(Direction dir) {
    switch (dir) {
    case mUP:
      tileManager.move_tiles_u();
      break;
    case mDOWN:
      tileManager.move_tiles_d();
      break;
    case mRIGHT:
      tileManager.move_tiles_r();
      break;
    case mLEFT:
      tileManager.move_tiles_l();
      break;
    }
  }
}