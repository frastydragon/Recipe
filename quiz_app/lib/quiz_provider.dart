import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizProvider with ChangeNotifier {
  List<dynamic> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;

  List<dynamic> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;

  Future<void> initializeQuiz(int amount, String category, String difficulty, String type) async {
    final response = await http.get(
      Uri.parse(
          'https://opentdb.com/api.php?amount=$amount &category=$category&difficulty=$difficulty&type=$type'),
    );

    if (response.statusCode == 200) {
      _questions = jsonDecode(response.body)['results'];
      _currentQuestionIndex = 0;
      _score = 0;
      notifyListeners();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api_category.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['trivia_categories'];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    _currentQuestionIndex++;
    notifyListeners();
  }
}
