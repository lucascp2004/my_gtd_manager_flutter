import 'package:flutter/material.dart';
class ThemeText{
  static TextStyle appBarTheme= const TextStyle(color: Colors.black,fontFamily: "Saira",fontWeight: FontWeight.bold, fontSize: 20);
  static TextStyle appLabels = const TextStyle(color: Colors.black,fontFamily: "Saira",fontWeight: FontWeight.bold);
  static TextStyle hintStyle1 = TextStyle(color: Colors.grey.shade600, fontFamily: "Ubuntu");
  static TextStyle hintStyle2 =  TextStyle(color: Colors.blue.shade700, fontFamily: "Ubuntu");
  static TextStyle currentDay = const TextStyle(color: Colors.black, fontFamily: "Ubuntu");
  static TextStyle dayPlanner = const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Saira");
  static TextStyle dropdown = TextStyle(
    color: Colors.grey.shade600,
    fontFamily: "Ubuntu",
    fontWeight: FontWeight.w500
  );
  static TextStyle datesLines = TextStyle(
      fontWeight:FontWeight.bold,
      color: Colors.blue.shade600,  
    );
  static TextStyle deleteButton = TextStyle(
    color: Colors.red.shade700,
    fontSize: 16,
  );
  static TextStyle black16Size =const TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
  static TextStyle darkblueLabelButton = TextStyle(
    color: Colors.blue.shade700,
    fontSize: 16,
  );
  static TextStyle popUpMenuLabel =const TextStyle(
    color: Colors.black54,
    fontSize: 14,

  );
  static TextStyle timeLabel = TextStyle(
    color: Colors.cyan.shade900,
  );
}