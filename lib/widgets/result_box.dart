import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
  });

  final int result;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: background,
        content: Padding(
          padding: EdgeInsets.all(70.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 30,
                    color: neutral,
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  child: Text('$result/$questionLength'),
                )
              ]),
        ));
  }
}
