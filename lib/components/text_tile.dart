import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final String text;
  final String? keyName;
  final TextStyle? textStyle;
  final int maxLines;
  const TextTile(this.text, {this.keyName, this.textStyle,this.maxLines =2,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      style: textStyle,
      text,
      key:(keyName==null)? null: Key(keyName!),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}