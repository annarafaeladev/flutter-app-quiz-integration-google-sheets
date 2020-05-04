import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final String message;
  final double loadingSize;
  final double fontSize;

  CircularProgress({
    this.message = 'Carregando',
    this.loadingSize = 64.0,
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: loadingSize,
            width: loadingSize,
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          ),
          Text(message,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
