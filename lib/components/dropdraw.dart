import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';

// ignore: must_be_immutable
class MyDropdown extends StatefulWidget {
  final Map<String, int> values;
  IntController currentValue;
  VoidCallback? afterSetState;

  MyDropdown(this.values, this.currentValue, {this.afterSetState, super.key});
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  /*@override
  void dispose() {
    widget.currentValue.value=1;
    super.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
        color: const Color.fromARGB(211, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: DropdownButton<int>(
          isExpanded: true,
          value: widget.currentValue.value,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            //color: Colors.deepPurpleAccent,
          ),
          onChanged: (int? newValue) {
            if (newValue != null) {
              if (newValue != widget.currentValue.value) {
                setState(() {
                  widget.currentValue.value = newValue;
                });
                widget.afterSetState?.call();
              }
            }
          },
          items: widget.values.keys.map<DropdownMenuItem<int>>((String key) {
            return DropdownMenuItem<int>(
              key: Key("$key dp"),
              value: widget.values[key],
              child: Text(
                style: ThemeText.dropdown,
                key,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
