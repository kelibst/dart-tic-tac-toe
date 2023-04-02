class PlayGame {
  var board = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "]
  ];

  void printBoard(board) {
    print("   1   2   3");
    print("1  ${board[0][0]} | ${board[0][1]} | ${board[0][2]} ");
    print("  ---+---+---");
    print("2  ${board[1][0]} | ${board[1][1]} | ${board[1][2]} ");
    print("  ---+---+---");
    print("3  ${board[2][0]} | ${board[2][1]} | ${board[2][2]} ");
  }

  void startGame() {
    printBoard(board);
  }
}
