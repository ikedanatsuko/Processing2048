class MoveAnimation {
  int moveTime = 10;

  // movesが含む情報・・・それぞれのタイルの
  // 移動距離x、移動距離y、レベルアップするか
  MoveAnimation(int[][] tiles, int[][] moves) {
    // Get ready to move if a constructer is generated
    init();
    phase = Phase.pMove;
  }

  void init() {

  }


}
