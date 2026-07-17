import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';

class SimpleCheckBox extends StatefulWidget {
  const SimpleCheckBox({super.key, required this.currentValue});

  final BoolControler currentValue;

  @override
  State<SimpleCheckBox> createState() => _SimpleCheckBoxState();
}

class _SimpleCheckBoxState extends State<SimpleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.currentValue.value,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            widget.currentValue.value = value;
          });
        }
      },
    );
  }
}
