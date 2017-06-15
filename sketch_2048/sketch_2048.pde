final int TILE_SIZE = 4;
final int LEVEL_SIZE = 6;

int[][] tiles = new int[TILE_SIZE][TILE_SIZE];
color[] tileColor = new color[LEVEL_SIZE];

void setup() {
  tileColor[0] = color(-1);
  tileColor[1] = color(0, 0, 255);
  tileColor[2] = color(0, 255, 0);
  tileColor[3] = color(255, 255, 0);
  tileColor[4] = color(255, 0, 255);
  tileColor[5] = color(255, 0, 0);
  
  for (int y = 0; y < TILE_SIZE; y++) {
    for (int x = 0; x < TILE_SIZE; x++) {
      tiles[x][y] = 0;
    }
  }
  size(300, 300);
  set_new_tile();
}

void draw() {
  background(0);
  draw_lines();
  draw_tiles();
}

void set_new_tile() {
  ArrayList<PVector> emptyTiles = new ArrayList<PVector>(); 
  for (int y = 0; y < TILE_SIZE; y++) {
    for (int x = 0; x < TILE_SIZE; x++) {
      if (tiles[x][y] == 0) {
        emptyTiles.add(new PVector(x, y));
      }
    }
  }
  PVector newTilePos = emptyTiles.get(floor(random(emptyTiles.size())));
  tiles[int(newTilePos.x)][int(newTilePos.y)] = 1;
}

void draw_tiles() {
  noStroke();
  rectMode(CENTER);
  float tileWidth = width / TILE_SIZE;
  float tileHeight = height / TILE_SIZE;
  for (int y = 0; y < TILE_SIZE; y++) {
    for (int x = 0; x < TILE_SIZE; x++) {
      if (tiles[x][y] == 0) continue;
      fill(tileColor[tiles[x][y] - 1]);
      rect(tileWidth * (x + 0.5), tileHeight * (y + 0.5), tileWidth * 0.8, tileHeight * 0.8);
    }
  }
}

void draw_lines() {
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

void keyPressed() {
  if (keyCode == UP) {
    move_tiles_u();
  }
  if (keyCode == DOWN) {
    move_tiles_d();
  }
  if (keyCode == RIGHT) {
    move_tiles_r();
  }
  if (keyCode == LEFT) {
    move_tiles_l();
  }
}


// ----------------------------------------- move method
// Up
void move_tiles_u() {
  int currentLevel, currentPos;
  for (int x = 0; x < TILE_SIZE; x++) {
    currentLevel = 0;
    currentPos = 0;

    int y = 0;
    while (y < TILE_SIZE) {

      if (tiles[x][y] != 0) {
        // その列で初めてタイルが現れた場合
        if (currentLevel == 0) {
          currentLevel = tiles[x][y];
          if (currentPos != y) {
            tiles[x][currentPos] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        // 最後に観測したタイルと違うタイルが現れた場合
        else if (currentLevel != tiles[x][y]) {
          currentLevel = tiles[x][y];
          currentPos++;
          if (currentPos != y) {
            tiles[x][currentPos] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else {
          // 最後に観測したタイルと同じタイルが現れた場合
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
  set_new_tile();
}

// Down
void move_tiles_d() {
  int currentLevel, currentPos;
  for (int x = 0; x < TILE_SIZE; x++) {
    currentLevel = 0;
    currentPos = TILE_SIZE - 1;

    int y = TILE_SIZE - 1;
    while (y >= 0) {

      if (tiles[x][y] != 0) {
        if (currentLevel == 0) {
          currentLevel = tiles[x][y];
          if (currentPos != y) {
            tiles[x][currentPos] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else if (currentLevel != tiles[x][y]) {
          currentLevel = tiles[x][y];
          currentPos--;
          if (currentPos != y) {
            tiles[x][currentPos] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else {
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
  set_new_tile();
}

// Right
void move_tiles_r() {
  int currentLevel, currentPos;
  for (int y = 0; y < TILE_SIZE; y++) {
    currentLevel = 0;
    currentPos = TILE_SIZE - 1;

    int x = TILE_SIZE - 1;
    while (x >= 0) {

      if (tiles[x][y] != 0) {
        if (currentLevel == 0) {
          currentLevel = tiles[x][y];
          if (currentPos != x) {
            tiles[currentPos][y] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else if (currentLevel != tiles[x][y]) {
          currentLevel = tiles[x][y];
          currentPos--;
          if (currentPos != x) {
            tiles[currentPos][y] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else {
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
  set_new_tile();
}

// Left
void move_tiles_l() {
  int currentLevel, currentPos;
  for (int y = 0; y < TILE_SIZE; y++) {
    currentLevel = 0;
    currentPos = 0;

    int x = 0;
    while (x < TILE_SIZE) {

      if (tiles[x][y] != 0) {
        if (currentLevel == 0) {
          currentLevel = tiles[x][y];
          if (currentPos != x) {
            tiles[currentPos][y] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else if (currentLevel != tiles[x][y]) {
          currentLevel = tiles[x][y];
          currentPos++;
          if (currentPos != x) {
            tiles[currentPos][y] = tiles[x][y];
            tiles[x][y] = 0;
          }
        }
        else {
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
  set_new_tile();
}