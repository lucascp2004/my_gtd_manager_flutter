import 'package:flutter/material.dart';
class PopUpIcon extends StatelessWidget {
  final bool isolated;
  const PopUpIcon(
  this.isolated,
  {
    
    super.key,
  });
  Container smallBall(){
    return Container(
      height: 4,
      width: 4,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return
    
    
    SizedBox(
      
      height:IconTheme.of(context).size!-6,
      width: (isolated)? 6: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          smallBall(),
          smallBall(),
          smallBall()
        ],
      ),
    );

  }
}