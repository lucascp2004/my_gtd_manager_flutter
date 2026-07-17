import 'package:flutter/material.dart';

BoxDecoration getDecoration(bool isDragging, {Color? color}) {
  return BoxDecoration(
    color: color,
    border: (isDragging) ? Border.all(color: Colors.blue, width: 1) : Border.all(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}
