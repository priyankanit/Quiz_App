import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/service/api.dart';

class QuizState extends ChangeNotifier {
  
  Quiz? _quiz;
  int _score = 0;
   List<int?> selectedOptions = [];

  Quiz? get quiz => _quiz;
  int get score => _score; 
  


  void incrementScore() {
    _score++;
    notifyListeners();
  }
  // Select an option and update score
  void selectOption(int questionIndex, int optionIndex) {
    if (selectedOptions[questionIndex] == null) {
      selectedOptions[questionIndex] = optionIndex;

      // Check if the selected option is correct
      final selectedOption = _quiz!.questions[questionIndex].options[optionIndex];
      if (selectedOption.isCorrect) {
        _score++;
      }
      notifyListeners();
    }
  }

  

  //Reset the quiz state when retrying the quiz
  void resetQuiz() {
    selectedOptions = List.filled(quiz?.questions.length ?? 0, null); 
    _score = 0; // Reset selected options
    notifyListeners();
  }
 


  Future<void> loadQuiz() async {
    try{
       _quiz = await QuizService().fetchQuizData();
       selectedOptions = List.filled(_quiz!.questions.length, null);
       _score=0;
       debugPrint('Quiz data fetched: $_quiz');
    notifyListeners();
    } catch (e) {
      print('Error loading quiz: $e');
      throw Exception('Failed to fetch quiz data: $e');
   
  
  }
}
}



