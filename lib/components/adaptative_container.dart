import 'package:flutter/material.dart';

class AdaptativeContainer extends StatelessWidget {
  final Widget content;
  const AdaptativeContainer(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width - 20,
      child: content,
    );
  }
}