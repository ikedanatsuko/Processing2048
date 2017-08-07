class MoveAnimation {
  ArrayList<MoveParam> moves = new ArrayList();

  MoveAnimation() {
  }

  MoveAnimation(ArrayList<MoveParam> moves) {
    if (moves.size() > 0) {
      this.moves = new ArrayList();
      for (MoveParam param : moves) {
        this.moves.add(param);
      }
      phase = Phase.pMove;
    }
  }

  void display() {
    if (moves != null) {
      for (MoveParam param : moves) {
        param.move();
        param.display();
      }
    }
  }
}
