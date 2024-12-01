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
      appBar: AppBar(
        title: const Text('Quiz Setup'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent.shade100, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Customize Your Quiz',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Number of Questions',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Difficulty',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Question Type',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ],
                  ),
                ),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
