import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe/provider/tic_tac_toe_provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late TicTacToeProvider sut;
  late MockBuildContext mockContext;

  setUp(() {
    sut = TicTacToeProvider();
    mockContext = MockBuildContext();
  });

  test('initial values are correct', () {
    expect(sut.oTurn, true);
    expect(sut.filledBoxes, 0);
    expect(sut.displayElements,
        [null, null, null, null, null, null, null, null, null]);
  });

  group('tappedBox method cases', () {
    test('tappedBox should assing a list element and sum +1 to filledBoxes',
        () {
      const int index = 0;
      sut.tappedBox(mockContext, index);
      expect(sut.displayElements[index], true);
      expect(sut.filledBoxes, 1);
    });

    test('tappedBox should call _checkWinner when a winner exists', () {
      const int indexToWin = 2;
      sut.displayElements[0] = true;
      sut.displayElements[1] = true;
      expect(sut.tappedBox(mockContext, indexToWin),
          'The winner of this match is X!!');
      expect(sut.filledBoxes, 0);
    });
  });

  group('showTurn method cases', () {
    test('show turn should return an empty string', () {
      expect(sut.showTurn(0), '');
    });

    test('show turn should return an O', () {
      sut.displayElements[0] = false;
      expect(sut.showTurn(0), 'O');
    });
  });
}
