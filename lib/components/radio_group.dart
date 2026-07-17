import 'package:flutter/material.dart';
import '../../controllers/int_controller.dart';

// ignore: must_be_immutable
class MyRadioGroup extends StatefulWidget {
  final bool isList;
  final bool isRow;
  final List<String> texts;
  IntController optionController;

  MyRadioGroup(
    this.isRow,
    this.texts,
    this.optionController,
    this.isList, {
    super.key,
  });

  int getOption() {
    return optionController.value;
  }

  @override
  State<MyRadioGroup> createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroup> {
  void setValue(int value) {
    widget.optionController.value = value;
  }

  String getkey(int index) {
    if (widget.isList) {
      return "$index L";
    } else {
      return "$index SL";
    }
  }

  Widget createRadioList(int index) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.blue,
          key: Key(getkey(index)),
          groupValue: widget.optionController.value,
          value: index,
          onChanged: ((value) {
            setValue(value!);
            setState(() {});
          }),
        ),
        Text(widget.texts[index]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isRow)
        ? SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.texts.length,
                  (index) => createRadioList(index),
                ),
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List<Widget>.generate(
              widget.texts.length,
              (index) => createRadioList(index),
            ),
          );
  }
}
