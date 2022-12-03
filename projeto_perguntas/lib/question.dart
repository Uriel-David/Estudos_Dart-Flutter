import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question(this.question, {super.key});

  final String? question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Text(
        question!,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
