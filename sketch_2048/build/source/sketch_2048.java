import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_2048 extends PApplet {

// \u3042\u3068\u30a2\u30cb\u30e1\u30fc\u30b7\u30e7\u30f3\u3064\u3051\u305f\u3089\u30d7\u30ec\u30a4\u30a8\u30ea\u30a2\u306f\u5b8c\u6210
// \u5b9f\u884c\uff1acontrol + alt + b

final int TILE_SIZE = 4;
final float TILE_SCALE = 0.8f;
final int LEVEL_SIZE = 6;
final int MOVE_TIME = 10; // Size of frame required for movement

Phase phase = Phase.pStatic; // Initial state

float boxWidth, boxHeight;
PImage[] tileImage;

PlayArea playArea;
MoveAnimation moveAnimation = new MoveAnimation();

public void setup() {
  tileImage = new PImage[] {
    loadImage("tile/white.png"),
    loadImage("tile/blue.png"),
    loadImage("tile/green.png"),
    loadImage("tile/yellow.png"),
    loadImage("tile/pink.png"),
    loadImage("tile/red.png")
  };

  
  boxWidth = width / TILE_SIZE;
  boxHeight = height / TILE_SIZE;
  playArea = new PlayArea(TILE_SIZE, width, height);
  // playArea.init();
}

public void draw() {
  switch (phase) {
    case pStatic:
      playArea.display();
      break;
    case pMove:
      moveAnimation.display();
      break;
  }
}

public void keyPressed() {
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
class MoveAnimation {
  ArrayList<MoveParam> moves = new ArrayList();

  MoveAnimation() {
  }

  MoveAnimation(ArrayList<MoveParam> movesIn) {
    if (movesIn.size() > 0) {
      // moves = new ArrayList(movesIn.size());
      moves = new ArrayList();
      for (MoveParam param : movesIn) {
        moves.add(param);
      }
      phase = Phase.pMove;
    }
  }

  public void display() {
    if (moves != null) {
      playArea.displayBg();
      for (MoveParam param : moves) {
        param.move();
        param.display();
      }
    }
  }
}
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
    posX = boxWidth * (boxX + 0.5f);
    posY = boxHeight * (boxY + 0.5f);
    // Convert box goal into position goal
    goalX = boxWidth * (boxGoalX + 0.5f);
    goalY = boxHeight * (boxGoalY + 0.5f);

    // if (boxX == boxGoalX && boxY == boxGoalY) {
    //   move == false;
    // } else {
    //   move == true;
    // }
    move = (boxX == boxGoalX && boxY == boxGoalY ? false : true);
  }

  public void move() {
    if (move) {
      posX += speedX;
      posY += speedY;
      if (posX == goalX && posY == goalY) {
        // When move finish
        phase = Phase.pStatic;
      }
    }
  }

  public void display() {
    PImage img;
    imageMode(CENTER);
    img = tileImage[level - 1];
    image(img, posX, posY, boxWidth * TILE_SCALE, boxHeight * TILE_SCALE);
  }
}
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

  public void display() {
    playAreaDisplay.bg();
    playAreaDisplay.tiles(tileManager.tiles);
  }

  public void displayBg() {
    playAreaDisplay.bg();
  }

  // Change tile position
  public void move(Direction dir) {
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
class PlayAreaDisplay {
  // MoveMethod[][] moves = new MoveMethod[TILE_SIZE][TILE_SIZE];

  PlayAreaDisplay() {
  }

  // Draw static tiles
  public void tiles(int[][] tiles) {
    PImage img;
    imageMode(CENTER);
    for (int y = 0; y < TILE_SIZE; y++) {
      for (int x = 0; x < TILE_SIZE; x++) {
        if (tiles[x][y] == 0) continue;
        img = tileImage[tiles[x][y] - 1];
        image(img, boxWidth * (x + 0.5f), boxHeight * (y + 0.5f), boxWidth * TILE_SCALE, boxHeight * TILE_SCALE);
      }
    }
  }

  // Draw the base of the play area
  public void bg() {
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
}
// Control tiles
class TileManager {
  int[][] tiles;
  int tileSize;
  // MoveParam[][] moves;
  ArrayList<MoveParam> moves = new ArrayList();

  TileManager(int tileSize) {
    this.tileSize = tileSize;
    tiles = new int[tileSize][tileSize];
    init_tiles();
  }

  public void init_tiles() {
    tiles = new int[tileSize][tileSize];
    for (int y = 0; y < tileSize; y++) {
      for (int x = 0; x < tileSize; x++) {
        tiles[x][y] = 0;
      }
    }
    set_new_tile(tiles);
  }

  public void set_new_tile(int[][] tiles) {
    ArrayList<PVector> emptyTiles = new ArrayList();
    for (int y = 0; y < tileSize; y++) {
      for (int x = 0; x < tileSize; x++) {
        if (tiles[x][y] == 0) {
          emptyTiles.add(new PVector(x, y));
        }
      }
    }
    PVector newTilePos = emptyTiles.get(floor(random(emptyTiles.size())));
    tiles[PApplet.parseInt(newTilePos.x)][PApplet.parseInt(newTilePos.y)] = 1;
  }

  // ------------------------------------ Move tiles and return moves
  // Up
  public ArrayList<MoveParam> move_tiles_u() {
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
              // moves.add(new MoveParam(0, y - recentPos, false));
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
              // moves.add(new MoveParam(0, y - recentPos, false));
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            // When a tile same as the tile which observed appears recently
            // moves.add(new MoveParam(0, y - recentPos, true));
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
  public ArrayList<MoveParam> move_tiles_d() {
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
              // moves.add(new MoveParam(0, y - recentPos, false));
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
              // moves.add(new MoveParam(0, y - recentPos, false));
              moves.add(new MoveParam(x, y, x, recentPos, tiles[x][y]));
              tiles[x][recentPos] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            // moves.add(new MoveParam(0, y - recentPos, true));
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
  public ArrayList<MoveParam> move_tiles_r() {
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
              // moves.add(new MoveParam(x - recentPos, y, false));
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
              // moves.add(new MoveParam(x - recentPos, y, false));
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            // moves.add(new MoveParam(x - recentPos, y, true));
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
  public ArrayList<MoveParam> move_tiles_l() {
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
              // moves.add(new MoveParam(x - recentPos, y, false));
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
              // moves.add(new MoveParam(x - recentPos, y, false));
              moves.add(new MoveParam(x, y, recentPos, y, tiles[x][y]));
              tiles[recentPos][y] = tiles[x][y];
              tiles[x][y] = 0;
            } else {
              moves.add(new MoveParam(x, y, x, y, tiles[x][y]));
            }
          } else {
            // moves.add(new MoveParam(x - recentPos, y, true));
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
  public void settings() {  size(300, 300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_2048" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
