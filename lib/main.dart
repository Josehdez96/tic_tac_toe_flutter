import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/tic_tac_toe_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((_) => TicTacToeProvider()),
        )
      ],
      child: const MaterialApp(home: MainScreen()),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TicTacToeProvider ticTacToeProvider =
        Provider.of<TicTacToeProvider>(context);
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.5,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: ((context, index) => GestureDetector(
                  key: ValueKey('gesture-detector-key-$index'),
                  onTap: () {
                    if (ticTacToeProvider.filledBoxes == 9) {
                      showCustomDialog(context, 'We have a draw!');
                    }

                    String? winnerMessage = ticTacToeProvider.tappedBox(index);
                    if (winnerMessage != null) {
                      showCustomDialog(context, winnerMessage);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        ticTacToeProvider.showTurn(index),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 35),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Play again'),
          )
        ],
      ),
    );
  }
}
