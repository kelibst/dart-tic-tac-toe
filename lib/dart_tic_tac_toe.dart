import 'dart:io';

class User {
  String? name;
  String? symbol;
}

class PlayGame {
  var board = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  var winningStrategies = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], //# Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], //# Columns
    [0, 4, 8], [2, 4, 6] //# Diagonals
  ];
  User? currentPlayer;
  User user = User();
  User computer = User();

  void printBoard(board) {
    print("   1   2   3");
    print("1  ${board[0]} | ${board[1]} | ${board[2]} ");
    print("  ---+---+---");
    print("2  ${board[3]} | ${board[4]} | ${board[5]} ");
    print("  ---+---+---");
    print("3  ${board[6]} | ${board[7]} | ${board[8]} ");
  }

  String getName() {
    stdout.write('Enter your name: ');
    String? name = stdin.readLineSync();

    if (name == null || name.isEmpty) {
      return getName();
    } else {
      return name;
    }
  }

  bool validMove(int position, List<String> board) {
    return position >= 1 && position <= 9 && board[position - 1] == " ";
  }

  void changePlayer() {
    if (currentPlayer == computer) {
      currentPlayer = user;
    } else {
      currentPlayer = computer;
    }
  }

  void makeMove(int position, User currentPlayer) {
    if (currentPlayer.symbol != null) {
      board[position - 1] = currentPlayer.symbol!;
    }
  }

  void play() {
    int i = 0;
    currentPlayer = user;
    while (i < 9) {
      printBoard(board);
      print('It is ${currentPlayer?.name}s turn!');
      stdout.write('Enter a number between 1-9 that is not yet taken: ');
      String? position = stdin.readLineSync();
      int number = int.tryParse(position ?? "") ?? 0;
      if (validMove(number, board)) {
        makeMove(number, currentPlayer!);
        changePlayer();
        ++i;
      } else {
        print('Invalid move! Please try again.');
        break;
      }
    }
  }

  void startGame() {
    user.name = getName();
    user.symbol = "X";
    computer.name = 'computer';
    computer.symbol = 'O';
    print("Welcome ${user.name}! your symbol for this game is X");
    play();
  }
}
