import 'package:flutter/material.dart';

import 'package:premier_league_trivia/widgets/answer_button.dart';
import 'package:premier_league_trivia/data/questions.dart';
import '../models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  late List<QuizQuestion> shuffledQuestions;

  @override
  void initState() {
    super.initState();
    shuffledQuestions = [...questions];
    shuffledQuestions.shuffle();
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      if (currentQuestionIndex < shuffledQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Handle end of questions or quiz completion
        // You can navigate to a result screen or restart the quiz here.
        // For simplicity, we'll just loop back to the first question.
        currentQuestionIndex = 0;
        shuffledQuestions.shuffle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = shuffledQuestions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: const TextStyle(
                color: Color.fromARGB(255, 55, 45, 96),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map(
              (answer) {
                return AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
