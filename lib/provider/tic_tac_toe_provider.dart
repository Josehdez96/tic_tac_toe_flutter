import 'package:flutter/material.dart';

class TicTacToeProvider extends ChangeNotifier {
  bool oTurn = true;
  int filledBoxes = 0;
  List<bool?> displayElements = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];

  String? tappedBox(BuildContext context, int index) {
    displayElements[index] = oTurn;
    filledBoxes++;
    _changeTurn();
    if (_checkWinner()) {
      String savedWinnerMessage =
          'The winner of this match is ${displayElements[index]! ? 'X' : 'O'}!!';
      _clearBoard();
      return savedWinnerMessage;
    }
    notifyListeners();
    return null;
  }

  String showTurn(int index) {
    if (displayElements[index] != null) {
      return displayElements[index]! ? 'X' : 'O';
    } else {
      return '';
    }
  }

  void _changeTurn() {
    oTurn = !oTurn;
  }

  bool _checkThreeElements(bool? element1, bool? element2, bool? element3) {
    if (element1 != null && element2 != null && element3 != null) {
      return (element1 == element2 &&
          element2 == element3 &&
          element1 == element3);
    } else {
      return false;
    }
  }

  bool _checkWinner() {
    if (_checkRowsWinner() ||
        _checkColumnsWinner() ||
        _checkDiagonalsWinner()) {
      filledBoxes = 9;
      notifyListeners();
      return true;
    }
    return false;
  }

  void _clearBoard() {
    displayElements = [null, null, null, null, null, null, null, null, null];
    filledBoxes = 0;
    notifyListeners();
  }

  /// Rows
  /// [0, 1, 2] are equal,
  /// [3, 4, 5] are equal,
  /// [6, 7, 8] are equal
  bool _checkRowsWinner() {
    if (_checkThreeElements(
        displayElements[0], displayElements[1], displayElements[2])) {
      // Won
      return true;
    }
    if (_checkThreeElements(
        displayElements[3], displayElements[4], displayElements[5])) {
      // Won
      return true;
    }
    if (_checkThreeElements(
        displayElements[6], displayElements[7], displayElements[8])) {
      // Won
      return true;
    }
    return false;
  }

  /// Columns
  /// [0, 3, 6] are equal,
  /// [1, 4, 7] are equal,
  /// [2, 5, 8] are equal
  bool _checkColumnsWinner() {
    if (_checkThreeElements(
        displayElements[0], displayElements[3], displayElements[6])) {
      // Won
      return true;
    }
    if (_checkThreeElements(
        displayElements[1], displayElements[4], displayElements[7])) {
      // Won
      return true;
    }
    if (_checkThreeElements(
        displayElements[2], displayElements[5], displayElements[8])) {
      // Won
      return true;
    }
    return false;
  }

  /// Diagonals
  /// [0, 4, 8] are equal,
  /// [6, 4, 2] are equal
  bool _checkDiagonalsWinner() {
    if (_checkThreeElements(
        displayElements[0], displayElements[4], displayElements[8])) {
      // Won
      return true;
    }
    if (_checkThreeElements(
        displayElements[6], displayElements[4], displayElements[2])) {
      // Won
      return true;
    }
    return false;
  }
}
