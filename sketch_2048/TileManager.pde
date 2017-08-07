// Control tiles
class TileManager {
  int[][] tiles;
  int tileSize;
  ArrayList<MoveParam> moves = new ArrayList();

  TileManager(int tileSize) {
    this.tileSize = tileSize;
    tiles = new int[tileSize][tileSize];
    init_tiles();
  }

  void init_tiles() {
    tiles = new int[tileSize][tileSize];
    for (int y = 0; y < tileSize; y++) {
      for (int x = 0; x < tileSize; x++) {
        tiles[x][y] = 0;
      }
    }
    set_new_tile(tiles);
  }

  void set_new_tile(int[][] tiles) {
    ArrayList<PVector> emptyTiles = new ArrayList();
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
  ArrayList<MoveParam> move_tiles_u() {
    moves = new ArrayList();
    int currentLevel, recentPos;

    for (int x = 0; x < tileSize; x++) {
      currentLevel = 0;
      recentPos = 0;

      int y = 0;
      while (y < tileSize) {

        if (tiles[x][y] != 0) {
          // When a tile appears in the line for the first time
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (recentPos != y) {
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          }
          // When a tile unlike the tile which observed appears recently
          else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            recentPos++;
            if (recentPos != y) {
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            // When a tile same as the tile which observed appears recently
            moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
            tiles[x][recentPos] = currentLevel + 1;
            tiles[x][y] = 0;
            recentPos++;
            currentLevel = 0;
          }
          y = recentPos;
        }
        y++;
      }
    }
    set_new_tile(tiles);
    return moves;
  }

  // Down
  ArrayList<MoveParam> move_tiles_d() {
    moves = new ArrayList();
    int currentLevel, recentPos;

    for (int x = 0; x < tileSize; x++) {
      currentLevel = 0;
      recentPos = tileSize - 1;

      int y = tileSize - 1;
      while (y >= 0) {
        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (recentPos != y) {
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            recentPos--;
            if (recentPos != y) {
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
            tiles[x][recentPos] = currentLevel + 1;
            tiles[x][y] = 0;
            recentPos--;
            currentLevel = 0;
          }
          y = recentPos;
        }
        y--;
      }
    }
    set_new_tile(tiles);
    return moves;
  }

  // Right
  ArrayList<MoveParam> move_tiles_r() {
    moves = new ArrayList();
    int currentLevel, recentPos;

    for (int y = 0; y < tileSize; y++) {
      currentLevel = 0;
      recentPos = tileSize - 1;

      int x = tileSize - 1;
      while (x >= 0) {

        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (recentPos != x) {
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            recentPos--;
            if (recentPos != x) {
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
            tiles[recentPos][y] = currentLevel + 1;
            tiles[x][y] = 0;
            recentPos--;
            currentLevel = 0;
          }
          x = recentPos;
        }
        x--;
      }
    }
    set_new_tile(tiles);
    return moves;
  }

  // Left
  ArrayList<MoveParam> move_tiles_l() {
    moves = new ArrayList();
    int currentLevel, recentPos;

    for (int y = 0; y < tileSize; y++) {
      currentLevel = 0;
      recentPos = 0;

      int x = 0;
      while (x < tileSize) {

        if (tiles[x][y] != 0) {
          if (currentLevel == 0) {
            currentLevel = tiles[x][y];
            if (recentPos != x) {
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else if (currentLevel != tiles[x][y]) {
            currentLevel = tiles[x][y];
            recentPos++;
            if (recentPos != x) {
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
            tiles[recentPos][y] = currentLevel + 1;
            tiles[x][y] = 0;
            recentPos++;
            currentLevel = 0;
          }
          x = recentPos;
        }
        x++;
      }
    }
    set_new_tile(tiles);
    return moves;
  }
}
