import 'package:flutter/material.dart';

double containerWidth(BuildContext context) {
  var width = MediaQuery.of(context).size.width - 20;

  return (width < 500) ? width : 500;
}

class RoundedContainerOnTop extends StatelessWidget {
  final Color color;
  final Widget containerContent;
  const RoundedContainerOnTop(this.containerContent, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Ink(
        height: 48,
        width: containerWidth(context),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          border: Border.all(),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: color,
        ),
        child: containerContent,
      ),
    );
  }
}
