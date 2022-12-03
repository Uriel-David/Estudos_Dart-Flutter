import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(this.points, this.restartFormQuestion, {super.key});

  final int points;
  final void Function() restartFormQuestion;
  String get phraseResult {
    if (points < 8) {
      return 'Congratulations!';
    } else if (points < 12) {
      return 'You are Good!';
    } else if (points < 16) {
      return 'Very Cool!!';
    } else {
      return 'Level Jedi!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            phraseResult,
            style: const TextStyle(fontSize: 28),
          ),
        ),
        TextButton(
          onPressed: restartFormQuestion,
          child: const Text(
            'Restart?',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
