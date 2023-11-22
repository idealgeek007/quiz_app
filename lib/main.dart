import 'dart:ffi';

import 'package:flutter/material.dart';
import 'question.dart';

void main() {
  runApp(const Quizzy());
}

class Quizzy extends StatelessWidget {
  const Quizzy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

int qno = 0;

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  Question q1 = Question(
      q: 'You can lead a cow down stairs but not up stairs.', a: false);

  List<Question> questionBank = [
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: true),
    Question(q: 'A slug\'s blood is green.', a: true)
  ];

  @override
  Widget build(BuildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Center(
              child: Text(
            questionBank[qno].questionText,
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          )),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                  onPressed: () {
                    // User picked true
                    setState(() {
                      if (questionBank[qno].questionAnswer == true) {
                        scoreKeeper.add(
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        );
                      } else {
                        scoreKeeper.add(
                          const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        );
                      }
                      qno++;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text(
                    'TRUE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  )),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (questionBank[qno].questionAnswer == false) {
                        scoreKeeper.add(
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        );
                      } else {
                        scoreKeeper.add(
                          const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        );
                      }
                      qno++;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text(
                    'FALSE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  )),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
Quesiton 1: 'You can lead a cow down stairs but not up stairs. ' ,false,
Question 2: 'Approximately one quarter of human bones are in the feet.' true,
Question 3: 'A slug\'s blood is green.',  true,
*/
