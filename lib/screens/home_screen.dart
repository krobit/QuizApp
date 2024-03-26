import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/option_card.dart';
import '../constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Question> _questions = [
    Question(
      id: '1',
      title: 'What is the capital of India?',
      options: {
        'New Delhi': true,
        'Bangalore': false,
        'Mumbai': false,
        'Chennai': false,
      },
    ),
    Question(
      id: '2',
      title: 'What is the capital of USA?',
      options: {
        'Washington D.C.': true,
        'New York': false,
        'Los Angeles': false,
        'Chicago': false,
      },
    ),
    Question(
      id: '3',
      title: 'What is the capital of China?',
      options: {
        'Beijing': true,
        'Shanghai': false,
        'Shenzhen': false,
        'Guangzhou': false,
      },
    ),
  ];

  int index = 0;
  bool isPressed = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      setState(() {
        index++;
        isPressed = false;
      });
    }
  }

  void changeColor() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(color: neutral),
        ),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          QuestionWidget(
            indexAction: index,
            question: _questions[index].title,
            totalQuestions: _questions.length,
          ),
          const Divider(
            color: neutral,
          ),
          const SizedBox(
            height: 25.0,
          ),
          for (int i = 0; i < _questions[index].options.length; i++)
            OptionCard(
              option: _questions[index].options.keys.toList()[i],
              color: isPressed
                  ? _questions[index].options.values.toList()[i] == true
                      ? correct
                      : incorrect
                  : neutral,
              onTap: changeColor,
            ),
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
