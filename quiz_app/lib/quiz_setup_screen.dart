import 'package:flutter/material.dart';
import 'quiz_provider.dart';
import 'quiz_screen.dart';
import 'package:provider/provider.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({Key? key}) : super(key: key);

  @override
  _QuizSetupScreenState createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  int _numberOfQuestions = 5;
  String _selectedCategory = '9'; // Default: General Knowledge
  String _difficulty = 'easy';
  String _type = 'multiple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Number of Questions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: _numberOfQuestions,
              onChanged: (value) {
                setState(() {
                  _numberOfQuestions = value!;
                });
              },
              items: [5, 10, 15]
                  .map((e) => DropdownMenuItem<int>(
                        value: e,
                        child: Text('$e'),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Consumer<QuizProvider>(
              builder: (context, provider, _) {
                return FutureBuilder<List<dynamic>>(
                  future: provider.fetchCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: snapshot.data!
                          .map(
                            (category) => DropdownMenuItem<String>(
                              value: category['id'].toString(),
                              child: Text(category['name']),
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Difficulty',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _difficulty,
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                });
              },
              items: ['easy', 'medium', 'hard']
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Question Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
              items: ['multiple', 'boolean']
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<QuizProvider>(context, listen: false)
                      .initializeQuiz(_numberOfQuestions-1, _selectedCategory, _difficulty, _type);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
