import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(this.answer, this.onPressed, {super.key});

  final String? answer;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: onPressed,
            child: Text(
              answer!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ));
  }
}
