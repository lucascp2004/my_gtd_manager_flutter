import 'package:flutter/material.dart';
class FunctionProvider extends InheritedWidget {
  final Future<void> Function(int,bool) sharedFunction;

  const FunctionProvider({
    super.key,
    required this.sharedFunction,
    required super.child,
  });

  @override
  bool updateShouldNotify(FunctionProvider oldWidget) {
    return sharedFunction != oldWidget.sharedFunction;
  }

  static FunctionProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FunctionProvider>();
  }
}
