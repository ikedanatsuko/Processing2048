// Control tiles
class TileManager {
  // MoveParam[] moves = {};
  int[][] tiles;
  int tileSize

  TileManager(int tileSize) {
    this.tileSize = tileSize;
    tiles = new int[tileSize][tileSize];
  }

  int[][] getTiles() {
    return tiles;
  }

  void init_tiles() {
    int[][] tiles = new int[tileSize][tileSize];
    for (int y = 0; y < tileSize; y++) {
      for (int x = 0; x < tileSize; x++) {
        tiles[x][y] = 0;
      }
    }
    set_new_tile(tiles);
  }

  void set_new_tile(int[][] tiles) {
    ArrayList<PVector> emptyTiles = new ArrayList<PVector>();
    for (int y = 0; y < tileSize; y++) {
      for (int x = 0; x < tileSize; x++) {
        if (tiles[x][y] == 0) {
          emptyTiles.add(new PVector(x, y));
        }
      }
    }
    PVector newTilePos = emptyTiles.get(floor(random(emptyTiles.size())));
    tiles[int(newTilePos.x)][int(newTilePos.y)] = 1;
  }

  // ------------------------------------ Move tiles and return moves
  // Up
  void move_tiles_u() { // movesも返すようにする
    int currentLevel, currentPos;

    for (int x = 0; x < tileSize; x++) {
      currentLevel = 0;
      currentPos = 0;

      int y = 0;
      while (y < tileSize) {

        if (tiles[x][y] != 0) {
          // When a tile appears in the line for the first time
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (currentPos != y) {

              tiles[x][currentPos] = tiles[x][y];
              tiles[x][y] = 0;
            }
          }
          // When a tile unlike the tile which observed appears recently
          else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            currentPos++;
            if (currentPos != y) {
              tiles[x][currentPos] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else {
            // When a tile same as the tile which observed appears recently
            tiles[x][currentPos] = currentLevel + 1;
            tiles[x][y] = 0;
            currentPos++;
            currentLevel = 0;
          }
          y = currentPos;
        }
        y++;
      }
    }
    set_new_tile(tiles);
  }

  // Down
  void move_tiles_d() {
    int currentLevel, currentPos;
    for (int x = 0; x < tileSize; x++) {
      currentLevel = 0;
      currentPos = tileSize - 1;

      int y = tileSize - 1;
      while (y >= 0) {

        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (currentPos != y) {
              tiles[x][currentPos] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            currentPos--;
            if (currentPos != y) {
              tiles[x][currentPos] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else {
            tiles[x][currentPos] = currentLevel + 1;
            tiles[x][y] = 0;
            currentPos--;
            currentLevel = 0;
          }
          y = currentPos;
        }
        y--;
      }
    }
    set_new_tile(tiles);
  }

  // Right
  void move_tiles_r() {
    int currentLevel, currentPos;
    for (int y = 0; y < tileSize; y++) {
      currentLevel = 0;
      currentPos = tileSize - 1;

      int x = tileSize - 1;
      while (x >= 0) {

        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (currentPos != x) {
              tiles[currentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            currentPos--;
            if (currentPos != x) {
              tiles[currentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else {
            tiles[currentPos][y] = currentLevel + 1;
            tiles[x][y] = 0;
            currentPos--;
            currentLevel = 0;
          }
          x = currentPos;
        }
        x--;
      }
    }
    set_new_tile(tiles);
  }

  // Left
  void move_tiles_l() {
    int currentLevel, currentPos;
    for (int y = 0; y < tileSize; y++) {
      currentLevel = 0;
      currentPos = 0;

      int x = 0;
      while (x < tileSize) {

        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (currentPos != x) {
              tiles[currentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            currentPos++;
            if (currentPos != x) {
              tiles[currentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            }
          } else {
            // Level up
            tiles[currentPos][y] = currentLevel + 1;
            tiles[x][y] = 0;
            currentPos++;
            currentLevel = 0;
          }
          x = currentPos;
        }
        x++;
      }
    }
    set_new_tile(tiles);
  }
}
