import 'package:flutter/material.dart';
import 'package:projeto_perguntas/answer.dart';
import 'package:projeto_perguntas/question.dart';

class FormQuestions extends StatelessWidget {
  const FormQuestions({
    required this.questions,
    required this.selectionQuestion,
    required this.answer,
    super.key,
  });

  final List<Map<String, Object>> questions;
  final int selectionQuestion;
  final void Function(int) answer;

  bool get hasQuestionSelection {
    return selectionQuestion < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> answers = hasQuestionSelection
        ? questions[selectionQuestion]['answers']! as List<Map<String, Object>>
        : [];

    return Column(
      children: <Widget>[
        Question(questions[selectionQuestion]['text'].toString()),
        ...answers.map((result) {
          return Answer(
            result['text'] as String,
            () => answer(int.parse(result['points'] as String)),
          );
        }).toList(),
      ],
    );
  }
}
