import 'dart:io';

class User {
  String name;
  String symbol;
  User(this.name, this.symbol);
}

class PlayGame {
  late List<String> board = List.filled(9, " ");
  static const List<List<int>> winningStrategies = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], //# Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], //# Columns
    [0, 4, 8], [2, 4, 6] //# Diagonals
  ];

  late User user = User("player1", "X");
  final User computer = User("Computer", "O");
  late User currentPlayer = user;

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
    String name = stdin.readLineSync()!;

    while (name.isEmpty) {
      stdout.write('Please enter a valid name: ');
      name = stdin.readLineSync()!;
    }
    return name;
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
    board[position - 1] = currentPlayer.symbol;
  }

  bool checkWinner(User player) {
    List<int> positions = List.generate(board.length, (index) => index + 1)
        .where((position) => board[position - 1] == player.symbol)
        .toList();
    return winningStrategies.any((strategy) =>
        strategy.every((position) => positions.contains(position)));
  }

  // bool checkWinner(List<String> board, User player) {
  //   for (var i = 0; i < winningStrategies.length; i++) {
  //     var a = winningStrategies[i][0];
  //     var b = winningStrategies[i][1];
  //     var c = winningStrategies[i][2];
  //     if (board[a] == player.symbol &&
  //         board[b] == player.symbol &&
  //         board[c] == player.symbol) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void play(User currentUser) {
    int i = 0;
    while (i < 9) {
      printBoard(board);
      print('It is ${currentPlayer?.name}s turn!');
      stdout.write('Enter a number between 1-9 that is not yet taken: ');
      String? position = stdin.readLineSync();
      int number = int.tryParse(position ?? "") ?? 0;
      if (validMove(number, board)) {
        makeMove(number, currentPlayer);
        if (checkWinner(currentPlayer)) {
          printBoard(board);
          print('${currentPlayer.name} wins!');
          return;
        }
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
    currentPlayer = user;
    print("Welcome ${user.name}! your symbol for this game is ${user.symbol}");
    play(currentPlayer);
  }
}
