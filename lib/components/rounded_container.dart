import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget containerContent;
  final BoxBorder? border;
  final Color color;
  final double? height;
  

  const RoundedContainer(this.containerContent, this.color,
      {super.key, this.height, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[1],
        borderRadius: BorderRadius.circular(10),
        border: border,
        color: color,
      ),
      child: containerContent,
    );
  }
}
