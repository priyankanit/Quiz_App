import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizState>(context);
    final quiz = quizProvider.quiz;

    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Results')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Fetch total questions and correct answers
    final totalQuestions = quiz.questions.length;
    final correctAnswers = quizProvider.score; // Use the `score` getter from the provider
    final scorePercentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: const Text('Quiz Results', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
      ),
      body:Column(
            children: [
              const SizedBox(height: 50),

              // Trophy Icon
              const Icon(Icons.emoji_events, size: 120, color: Colors.amber),

              const SizedBox(height: 20),

              // Congratulations Text
              const Text(
                "Congratulations",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Your Score Text
              const Text(
                "Your Score",
                style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 5),

              // Score Display with Colors
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$correctAnswers',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const TextSpan(
                      text: ' / ',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '$totalQuestions',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Encouraging Message
              Text(
                scorePercentage >= 80
                    ? "Excellent work! Keep it up! 🎉"
                    : (scorePercentage >= 50
                        ? "Good job! Keep practicing! 👍"
                        : "Keep trying! You’ll improve! 💪"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 30),

              // Questions and Answers List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, index) {
                      final question = quiz.questions[index];
                      final selectedOptionIndex = quizProvider.selectedOptions[index];
                      final selectedOption = (selectedOptionIndex != null &&
                              selectedOptionIndex >= 0 &&
                              selectedOptionIndex < question.options.length)
                          ? question.options[selectedOptionIndex]
                          : null;
                      final isCorrect = selectedOption != null && selectedOption.isCorrect;

                      return Card(
                        color: Colors.blueGrey.shade100,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question text
                              Text(
                                '${index + 1}. ${question.description}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),

                              // Selected answer and correctness
                              if (selectedOption != null)
                                Text(
                                  'Your Answer: ${selectedOption.description} ${isCorrect ? "(Correct)" : "(Incorrect)"}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),

                              // Correct answer if incorrect
                              if (selectedOption != null && !isCorrect)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Correct Answer: ${question.options.firstWhere((choice) => choice.isCorrect).description}',
                                    style: const TextStyle(fontSize: 16, color: Colors.lightBlue),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons: Retry and Back to Home
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Try Again Button
                  ElevatedButton(
                    onPressed: () {
                      quizProvider.resetQuiz();
                      Navigator.pushNamed(context, '/quiz');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('Try Again', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),

                  // Back to Home Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                       Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
    );
  }
}




