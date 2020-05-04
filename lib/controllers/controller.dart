import 'dart:math';

import 'package:quiz_flutter/models/question.dart';
import 'package:quiz_flutter/services/api.dart';

class QuizController {
  List<Question> _questionBank;

  Random _random = new Random();
  int _questionIndex = 0;
  bool _shiftAnswer;
  int _hitNumber = 0;

  int get questionsNumber => _questionBank.length;
  Question get question => _questionBank[_questionIndex];
  int get questionIndex => _questionIndex;
  int get hitNumber => _hitNumber;

  Future<void> initialize() async {
    _questionIndex = 0;
    _hitNumber = 0;
    _questionBank = await QuizApi.fetch();
    _questionBank.shuffle();
    _shiftAnswer = _random.nextBool();
  }

  void resetFase() {
    _questionIndex = 0;
    _hitNumber = 0;
  }

  void nextQuestion() {
    _questionIndex = ++_questionIndex % _questionBank.length;
    _shiftAnswer = _random.nextBool();
    _questionBank.shuffle();
    _shiftAnswer = _random.nextBool();
  }

  String getQuestion() {
    return _questionBank[_questionIndex].question;
  }

  String getAnswer1() {
    return _shiftAnswer
        ? _questionBank[_questionIndex].answer1
        : _questionBank[_questionIndex].answer2;
  }

  String getAnswer2() {
    return _shiftAnswer
        ? _questionBank[_questionIndex].answer2
        : _questionBank[_questionIndex].answer1;
  }

  bool correctAnswer(String answer) {
    var correct = _questionBank[_questionIndex].answer1 == answer;
    _hitNumber = hitNumber + (correct ? 1 : 0);
    return correct;
  }
}
