class PlayAreaDisplay {
  MoveMethod[][] moves = new MoveMethod[TILE_SIZE][TILE_SIZE];

  PlayAreaDisplay() {
  }

  void draw_tiles(int[][] tiles) {
    PImage img;
    imageMode(CENTER);
    for (int y = 0; y < TILE_SIZE; y++) {
      for (int x = 0; x < TILE_SIZE; x++) {
        if (tiles[x][y] == 0) continue;
        img = tileImage[tiles[x][y] - 1];
        image(img, boxWidth * (x + 0.5), boxHeight * (y + 0.5), boxWidth * TILE_SCALE, boxHeight * TILE_SCALE);
      }
    }
  }

  void draw_bg() {
    background(0);
    stroke(-1);
    float pos;
    for (int x = 0; x < TILE_SIZE; x++) {
      pos = width / TILE_SIZE * (x + 1);
      line(pos, 0, pos, height);
    }
    for (int y = 0; y < TILE_SIZE; y++) {
      pos = height / TILE_SIZE * (y + 1);
      line(0, pos, width, pos);
    }
  }

  // Get MoveMethod and create animation
}