import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String tooltip;
  const CustomFloatingActionButton ({required this.onPressed, required this.tooltip, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(178),
              spreadRadius: 3.5,
              blurRadius: 5,
              //offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FloatingActionButton(
          key: const Key("addListButton"),
          onPressed: onPressed,
        
          tooltip: tooltip,
          
          backgroundColor: Colors.grey.shade400, // White background
          foregroundColor: Colors.black, // Black foreground for the icon
          elevation: 15.0, // Shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0), // Shape of the FAB
            side:const BorderSide(color: Colors.black, width: 2.0), // Black border
          ),
          // Black plus icon
          child:const Icon(Icons.add, color: Colors.black),
        ),
      );
  }
}