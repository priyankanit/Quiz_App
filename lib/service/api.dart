 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz_model.dart';
 
 class QuizService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';


Future<Quiz> fetchQuizData() async {
  final response = await http.get(Uri.parse(apiUrl));

debugPrint('Response status code: ${response.statusCode}');
  debugPrint('Response body: ${response.body}');
  if (response.statusCode == 200) {
    return Quiz.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load quiz');
  }
}
 }