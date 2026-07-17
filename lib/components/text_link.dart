import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  const TextLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(25, 118, 210, 1),
        fontWeight: FontWeight.w500,
      )
    );
  }
}