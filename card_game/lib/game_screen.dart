import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'card_tile.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Matching Game'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: gameProvider.cards.length,
              itemBuilder: (context, index) {
                return CardTile(
                  card: gameProvider.cards[index],
                  onTap: () => gameProvider.flipCard(index),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: gameProvider.resetGame,
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
