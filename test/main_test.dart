import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/provider/tic_tac_toe_provider.dart';

String tappedBoxReturn = 'Winner!!';

class MockTicTacToeProvider extends Mock implements TicTacToeProvider {
  @override
  int get filledBoxes => 9;

  @override
  String? tappedBox(int index) {
    return tappedBoxReturn;
  }

  @override
  String showTurn(int index) {
    return 'O';
  }
}

void main() {
  late MockTicTacToeProvider mockTicTacToeProvider;

  setUp(() {
    mockTicTacToeProvider = MockTicTacToeProvider();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TicTacToeProvider>(
          create: ((_) => mockTicTacToeProvider),
        )
      ],
      child: const MaterialApp(home: MainScreen()),
    );
  }

  testWidgets('MultiProvider should exist', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MultiProvider), findsOneWidget);
  });

  testWidgets('FractionallySizedBox should exist', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(FractionallySizedBox), findsOneWidget);
  });

  testWidgets('Show draw dialog', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const ValueKey('gesture-detector-key-1')));
    await tester.pumpAndSettle();
    expect(find.text('We have a draw!'), findsOneWidget);
  });

  testWidgets('Show winner dialog', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byKey(const ValueKey('gesture-detector-key-1')));
    await tester.pumpAndSettle();
    expect(find.text(tappedBoxReturn), findsOneWidget);
  });
}
