// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/answer.dart';
import 'package:projeto_perguntas/question.dart';

void main() {
  runApp(const QuestionApp());
}

class _QuestionAppState extends State<QuestionApp> {
  var _selectionQuestion = 0;

  void _answer() {
    setState(() {
      _selectionQuestion++;
    });
    print(_selectionQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> questions = [
      {
        'text': 'what is your favorite color?',
        'answer': ['Black', 'Red', 'Green', 'White']
      },
      {
        'text': 'what\'s your favorite animal?',
        'answer': ['Habbit', 'Snake', 'Tiger', 'Lion']
      },
      {
        'text': 'what is your favorite Console?',
        'answer': ['PC', 'Playstation 4', 'Xbox One', 'Nitendo Switch']
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
        ),
        body: Column(
          children: <Widget>[
            Question(questions[_selectionQuestion]['text'].toString()),
            Answer('Answer 1', _answer),
            Answer('Answer 2', _answer),
            Answer('Answer 3', _answer),
          ],
        ),
      ),
    );
  }
}

class QuestionApp extends StatefulWidget {
  const QuestionApp({super.key});

  @override
  _QuestionAppState createState() {
    return _QuestionAppState();
  }
}
