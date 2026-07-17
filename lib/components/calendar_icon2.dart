
import 'package:flutter/material.dart';

class CalendarIcon2 extends StatelessWidget {

  final VoidCallback onPressed;
  
  const CalendarIcon2(
  
    this.onPressed,
    
    {super.key}
  );
  @override
  Widget build(BuildContext context) {

      return InkWell(
        onTap: onPressed,
        child: Container(
          margin:const EdgeInsets.only(top: 3),
          child: Column(
            children: [
              Container(
                width: 20, 
                height: 3,
                decoration: const BoxDecoration(
                  border: Border(
                    //top:BorderSide(width: 1.5,color: Colors.blue),
                    left: BorderSide(width: 3,color: Colors.blue),
                    right: BorderSide(width: 3,color: Colors.blue),
                  ),
                ),
                
          
          
              ),
              Container(
                width: 28,
                height: 3.5,
                color: Colors.blue.shade600,
                
              ),
              Container(
                width: 28,
                height: 25,
                decoration: BoxDecoration(
                  
                  
                  border: Border.all(width: 2,color: Colors.blue),
                  borderRadius: BorderRadius.circular(2.0),
                  
                ),
                child: Center(
                  child: Container(
                    width: 17,
                    height: 15,
                    decoration: const BoxDecoration(
                      border:Border(
                        top:BorderSide(width: 5,color: Colors.blue),
                        bottom:BorderSide(width: 5,color: Colors.blue),
                      )
                    ),
                  )
                )
              
              ),
            ],
          ),
        ),
      );
    
  }
}