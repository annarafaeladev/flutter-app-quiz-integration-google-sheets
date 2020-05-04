import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:share/share.dart';

class FinishDialog {
  static Future show(
    BuildContext context, {
    int hitNumber,
    bool error,
    int cont,
    bool sair,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: CircleAvatar(
            backgroundColor:
                sair ? Colors.yellow : error ? Colors.red : Colors.green,
            maxRadius: 35.0,
            child: Icon(
              hitNumber < 6 ? Icons.warning : Icons.favorite,
              color: Colors.grey.shade900,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sair
                    ? 'O progresso do quiz não será armazenado, deseja continuar? '
                    : error ? 'Você errou 3 vezes nesta rodada' : 'Parabéns',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error
                    ? 'Você errou 3 de 10 nesta fase'
                    : 'Você acertou $hitNumber de ${10 * cont}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error
                    ? 'Que tal tentar mais uma vez?'
                    : 'Você chegou até a fase $cont',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('COMPARTILHAR'),
              onPressed: () {
                Share.share('Quiz Você acertou $hitNumber de 10!');
              },
            ),
            FlatButton(
              child: Text(sair ? 'Voltar ' : 'JOGAR NOVAMENTE'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Sair'),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
        );
      },
    );
  }
}
