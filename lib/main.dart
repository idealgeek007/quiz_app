import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  handleAnswer(true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  'TRUE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
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
                  handleAnswer(false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  'FALSE',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }

  void handleAnswer(bool userAnswer) {
    setState(() {
      if (quizBrain.checkEnd()) {
        int correctAnswers = scoreKeeper
            .where((widget) =>
                widget is Icon && (widget as Icon).icon == Icons.check)
            .length;

        int totalQuestions = quizBrain.totalQuestions();

        Alert(
          context: context,
          title: " Bingo ",
          desc: "Quiz complete\nYour score: $correctAnswers/$totalQuestions",
          image: Image.asset("assets/congrats.png"),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                // Reset the quiz state

                setState(() {
                  quizBrain = QuizBrain();
                  scoreKeeper = [];
                });
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        if (quizBrain.getQuestionAnswer() == userAnswer) {
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
        quizBrain.nextQuestion();
      }
    });
  }
}
