import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/option_card.dart';
import '../constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_box.dart';

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
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(
          context: context,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: _questions.length,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select any option"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (value && !isPressed) {
      score++;
    }
    setState(() {
      isPressed = true;
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Score: $score",
              style: const TextStyle(
                color: neutral,
                fontSize: 18.0,
              ),
            ),
          )
        ],
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
            GestureDetector(
              onTap: () => checkAnswerAndUpdate(
                  _questions[index].options.values.toList()[i]),
              child: OptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: isPressed
                    ? _questions[index].options.values.toList()[i] == true
                        ? correct
                        : incorrect
                    : neutral,
              ),
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
