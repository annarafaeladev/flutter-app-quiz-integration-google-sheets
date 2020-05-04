import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_flutter/components/circularProgress.dart';
import 'package:quiz_flutter/components/finishDialog.dart';
import 'package:quiz_flutter/components/message.dart';
import 'package:quiz_flutter/controllers/controller.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = QuizController();
  List<Widget> _scoreKeeper = [];
  int numberQuestion = 0;
  bool _loading = true;
  bool correct = false;
  int colorCorrect = 0;
  int cont = 1;
  bool err = false;
  int acerto = 0;
  int erro = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();
    numberQuestion = _controller.questionsNumber;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Quiz Fase $cont - ( $_scoreKeeper.length / 10 )'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: "Sair do Quiz",
                  child: Text("Sair do Quiz"),
                )
              ],
              onSelected: (value) {
                FinishDialog.show(context,
                    hitNumber: _controller.hitNumber,
                    error: false,
                    cont: cont,
                    sair: true);
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CircularProgress();

    if (_controller.questionsNumber == 0)
      return Message(
        'Sem questões',
        icon: Icons.warning,
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildQuestion(_controller.getQuestion()),
        _buildAnswerButton(_controller.getAnswer1(), 1),
        _buildAnswerButton(_controller.getAnswer2(), 2),
        FlatButton.icon(
          onPressed: () {
            if ((correct || err) && erro <= 3) {
              _controller.nextQuestion();
              setState(() {
                correct = false;
                err = false;
              });
            }
            if ((acerto + erro) == 10) {
              _scoreKeeper = [];
              acerto = 0;
              erro = 0;
              cont++;
            }
          },
          icon: Icon(
            Icons.navigate_next,
            color: correct ? Colors.green : err ? Colors.red : Colors.white,
            size: 45,
          ),
          label: Text(
            (((acerto + erro) == 10)) ? 'Próxima Fase ' : 'Próxima Questão',
            style: TextStyle(
                color: correct ? Colors.green : err ? Colors.red : Colors.white,
                fontSize: ((acerto + erro) == 10) ? 25 : 20),
          ),
        ),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildQuestion(String question) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        child: Center(
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(String _answer, int number) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (err && colorCorrect == number)
                  ? Colors.red
                  : (correct && colorCorrect == number)
                      ? Colors.green
                      : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: AutoSizeText(
                _answer,
                maxLines: 4,
                minFontSize: 12.0,
                maxFontSize: 32.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: (correct && colorCorrect == number)
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              correct = _controller.correctAnswer(_answer);
              err = !correct;

              if (correct) {
                acerto++;
              } else {
                erro++;
              }
              colorCorrect = number;
              _scoreKeeper.add(
                Icon(
                  correct ? Icons.check : Icons.close,
                  color: correct ? Colors.green : Colors.red,
                ),
              );
            });
            if (erro > 3) {
              FinishDialog.show(context,
                  hitNumber: _controller.hitNumber,
                  error: true,
                  cont: cont,
                  sair: false);
            }
          },
        ),
      ),
    );
  }

  _buildScoreKeeper() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _scoreKeeper,
      ),
    );
  }
}
