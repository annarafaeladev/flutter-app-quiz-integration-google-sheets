import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Message extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  Message(
    this.message, {
    this.icon,
    this.iconSize = 64.0,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child: Icon(
                icon,
                size: iconSize,
                color: Colors.black12,
              ),
              visible: icon != null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black26,
                ),
              ),
            ),
          ]),
    );
  }
}
