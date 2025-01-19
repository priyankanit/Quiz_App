import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/provider.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
   Map<int, int?> selectedOptions = {};

  void nextQuestion(BuildContext context) {
    final quizState = Provider.of<QuizState>(context, listen: false);

    // Save selected option to provider
  quizState.selectedOptions[currentQuestionIndex] = selectedOptions[currentQuestionIndex];

  // If correct, increase the score
    final question = quizState.quiz!.questions[currentQuestionIndex];
    final selectedOptionIndex = selectedOptions[currentQuestionIndex];

    if (selectedOptionIndex != null && question.options[selectedOptionIndex].isCorrect) {
      quizState.incrementScore();
    }

    if (currentQuestionIndex < quizState.quiz!.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        //selectedOptions = null; // Reset selection for the next question
      });
    } else {
      Navigator.pushNamed(context, '/result'); // Navigate to the result page
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizState>(context);
    final quiz = quizProvider.quiz;

    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = quiz.questions[currentQuestionIndex];
    final options = question.options; 

    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: const Text('QuizMaster', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text(
              'Quit',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / quiz.questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.teal.shade400,
            ),
            const SizedBox(height: 20),

            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${currentQuestionIndex + 1}.', // Question number
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 10), 
                Expanded(
                  child: Text(
                    question.description, // Question text
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
                ],
              ),
             ),
            const SizedBox(height: 20),

            // Options with Radio Buttons
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    title: Text(option.description), // Option text
                    leading: Radio<int>(
                      activeColor: Colors.teal.shade400,
                      value: index, // Value represents correctness
                      groupValue: selectedOptions[currentQuestionIndex],
                      onChanged: (value) {
                        setState(() {
                          selectedOptions[currentQuestionIndex] = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // Next Button
            ElevatedButton(
              onPressed: () {
                if (selectedOptions[currentQuestionIndex] == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select an answer!'),
                    ),
                  );
                } else {
                  nextQuestion(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                currentQuestionIndex < quiz.questions.length - 1
                    ? 'Next'
                    : 'Finish',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
