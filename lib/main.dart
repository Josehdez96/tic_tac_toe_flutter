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
                  onTap: () {
                    ticTacToeProvider.tappedBox(context, index);
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
}