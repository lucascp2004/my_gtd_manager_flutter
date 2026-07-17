import 'package:flutter/material.dart';

BoxDecoration getDecoration(bool isDragging, {Color? color}) {
  return BoxDecoration(
    color: color,
    border: (isDragging) ? Border.all(color: Colors.blue, width: 2) : null,
    borderRadius: (isDragging) ? BorderRadius.circular(4) : null,
  );
}