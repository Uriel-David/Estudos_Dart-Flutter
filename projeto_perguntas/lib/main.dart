// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/form.dart';
import 'package:projeto_perguntas/result.dart';

void main() {
  runApp(const QuestionApp());
}

class _QuestionAppState extends State<QuestionApp> {
  var _selectionQuestion = 0;
  var _userPointsTotal = 0;
  final List<Map<String, Object>> _questions = const [
    {
      'text': 'what is your favorite color?',
      'answers': [
        {'text': 'Black', 'points': '10'},
        {'text': 'Red', 'points': '7'},
        {'text': 'Green', 'points': '4'},
        {'text': 'White', 'points': '1'},
      ]
    },
    {
      'text': 'what\'s your favorite animal?',
      'answers': [
        {'text': 'Bunny', 'points': '10'},
        {'text': 'Snake', 'points': '7'},
        {'text': 'Tiger', 'points': '4'},
        {'text': 'Lion', 'points': '1'},
      ]
    },
    {
      'text': 'what is your favorite Console?',
      'answers': [
        {'text': 'PC', 'points': '10'},
        {'text': 'Playstation 4', 'points': '7'},
        {'text': 'Xbox One', 'points': '4'},
        {'text': 'Nitendo Switch', 'points': '1'},
      ]
    },
  ];

  void _answer(int userPoints) {
    setState(() {
      _selectionQuestion++;
      _userPointsTotal += userPoints;
    });
  }

  void _restartFormQuestion() {
    setState(() {
      _selectionQuestion = 0;
      _userPointsTotal = 0;
    });
  }

  bool get hasQuestionSelection {
    return _selectionQuestion < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
        ),
        body: hasQuestionSelection
            ? FormQuestions(
                questions: _questions,
                selectionQuestion: _selectionQuestion,
                answer: _answer,
              )
            : Result(_userPointsTotal, _restartFormQuestion),
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
