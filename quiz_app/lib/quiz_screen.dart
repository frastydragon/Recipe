import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';
import 'quiz_summary_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  late int _remainingTime;
  late QuizProvider _quizProvider;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _remainingTime = 15;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      if (_remainingTime > 0 && !_isAnswered) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      } else if (_remainingTime == 0) {
        _nextQuestion(false); // Time's up
      }
    });
  }

  void _nextQuestion(bool isCorrect) {
    if (_isAnswered) return;
    setState(() {
      _isAnswered = true;
    });

    _quizProvider.answerQuestion(isCorrect);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (_quizProvider.currentQuestionIndex < _quizProvider.questions.length) {
        setState(() {
          _isAnswered = false;
          _remainingTime = 15;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startTimer();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const QuizSummaryScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_quizProvider.currentQuestionIndex + 1} / ${_quizProvider.questions.length+1}'),
      ),
      body: _quizProvider.questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                LinearProgressIndicator(
                  value: (_quizProvider.currentQuestionIndex + 1) / (_quizProvider.questions.length+1),
                ),
                const SizedBox(height: 16),
                Text(
                  'Time Remaining: $_remainingTime seconds',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _quizProvider.questions.length,
                    itemBuilder: (context, index) {
                      final question = _quizProvider.questions[index];
                      final correctAnswer = question['correct_answer'];
                      final answers = [...question['incorrect_answers'], correctAnswer];

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question['question'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: answers.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ElevatedButton(
                                      onPressed: !_isAnswered
                                          ? () => _nextQuestion(answers[i] == correctAnswer)
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(double.infinity, 50),
                                      ),
                                      child: Text(
                                        answers[i],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (_isAnswered)
                              Text(
                                'Correct Answer: $correctAnswer',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
