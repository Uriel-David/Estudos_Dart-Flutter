// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';

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
    final questions = [
      'what is your favorite color?',
      'what\'s your favorite animal?',
      'what is your favorite video-game?',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
        ),
        body: Column(
          children: <Widget>[
            Text(questions.elementAt(_selectionQuestion)),
            ElevatedButton(
              onPressed: _answer,
              child: const Text('Answer 1'),
            ),
            Text(questions.elementAt(1)),
            ElevatedButton(
              onPressed: _answer,
              child: const Text('Answer 2'),
            ),
            Text(questions.elementAt(2)),
            ElevatedButton(
              onPressed: _answer,
              child: const Text('Answer 3'),
            ),
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
