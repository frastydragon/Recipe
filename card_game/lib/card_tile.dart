import 'package:flutter/material.dart';
import 'models/card_model.dart';

class CardTile extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const CardTile({Key? key, required this.card, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: card.isFaceUp || card.isMatched ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(4), // Add spacing between cards
        decoration: BoxDecoration(
          color: card.isFaceUp || card.isMatched ? Colors.white : Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: card.isFaceUp || card.isMatched
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            card.isFaceUp || card.isMatched ? card.content : '',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
