import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/theme_colors.dart';

class ContainerWithBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const ContainerWithBorder({required this.child, this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: MyColors.containerWithBorder,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: child,
    );
  }
}
