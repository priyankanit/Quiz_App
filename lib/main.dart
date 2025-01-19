import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/pages/quiz_page.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => QuizState(),
    child: const MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/quiz': (context) => const QuizPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}

