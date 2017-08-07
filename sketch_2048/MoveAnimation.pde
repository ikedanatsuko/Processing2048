class MoveAnimation {
  ArrayList<MoveParam> moves = new ArrayList();

  MoveAnimation() {
  }

  MoveAnimation(ArrayList<MoveParam> movesIn) {
    if (movesIn.size() > 0) {
      moves = new ArrayList();
      for (MoveParam param : movesIn) {
        moves.add(param);
      }
      phase = Phase.pMove;
    }
  }

  void display() {
    if (moves != null) {
      playArea.displayBg();
      for (MoveParam param : moves) {
        param.move();
        param.display();
      }
    }
  }
}
