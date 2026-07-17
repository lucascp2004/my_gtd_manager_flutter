import 'package:flutter/material.dart';


class MessageDialog extends StatelessWidget {
  final String text;
  const MessageDialog(this.text,{super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
        Text(
          text,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      actions: [
        TextButton(
          key:const Key("OK1"),
          onPressed: () {
            Navigator.pop(context);
          },
          child:const Text("Ok"),
        )
      ],
    );
  }
}
