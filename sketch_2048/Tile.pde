// For move animation
class Tile {
  int blockX, blockY; // Position expressed in block units
  float posX, posY; // Position expressed in pixels
  float speedX, speedY; // Move speed
  int level;
  
  Tile(int level, int blockX, int blockY, int distX, int distY) {
    this.blockX = blockX;
    this.blockY = blockY;
    this.level = level;
    
    speedX = (distX * (width / TILE_SIZE)) / MOVE_TIME;
    speedY = (distY * (height / TILE_SIZE)) / MOVE_TIME;
  }
}