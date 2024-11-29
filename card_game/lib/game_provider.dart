import 'dart:math';

import 'package:flutter/material.dart';
import 'models/card_model.dart';

class GameProvider extends ChangeNotifier {
  final List<CardModel> _cards = [];
  CardModel? _firstCard;
  CardModel? _secondCard;
  bool _isProcessing = false; // Prevent rapid taps during delay

  GameProvider() {
    resetGame();
  }

  List<CardModel> get cards => _cards;

  void resetGame() {
    _cards.clear();
    final List<String> contents = List.generate(8, (index) => '${index + 1}');
    final List<String> shuffledContents =
        [...contents, ...contents]..shuffle(Random());

    for (var content in shuffledContents) {
      _cards.add(CardModel(content: content));
    }

    _firstCard = null;
    _secondCard = null;
    _isProcessing = false;
    notifyListeners();
  }

  void flipCard(int index) {
    if (_isProcessing) return; // Prevent flipping during a delay
    final card = _cards[index];

    if (card.isFaceUp || card.isMatched) return;

    card.isFaceUp = true;

    if (_firstCard == null) {
      _firstCard = card;
    } else if (_secondCard == null) {
      _secondCard = card;
      _checkMatch();
    }

    notifyListeners();
  }

  void _checkMatch() {
    if (_firstCard != null && _secondCard != null) {
      if (_firstCard!.content == _secondCard!.content) {
        // Cards match
        _firstCard!.isMatched = true;
        _secondCard!.isMatched = true;
        _clearSelection();
      } else {
        // Cards do not match
        _isProcessing = true;
        Future.delayed(const Duration(seconds: 1), () {
          _firstCard!.isFaceUp = false;
          _secondCard!.isFaceUp = false;
          _clearSelection();
        });
      }
    }
  }

  void _clearSelection() {
    _firstCard = null;
    _secondCard = null;
    _isProcessing = false;
    notifyListeners();
  }
}
