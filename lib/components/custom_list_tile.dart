import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {

  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? longPress;
  final TextStyle? textStyle;
  final double? height;
  
  final bool isChecked;
  
  
  const CustomListTile(
     
    {
    required this.title,
    this.height,
    super.key,
    this.isChecked=false,
    
    this.leading,
    this.trailing,
    this.longPress,
    this.onTap,
    this.textStyle,
    
  });

  @override
  Widget build(BuildContext context) {
    
    
    return InkWell(
        
        onLongPress: longPress,
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Row(
            children: <Widget>[
              (leading == null)
                  ? const SizedBox(
                      width: 7,
                    )
                  : leading!,
              Expanded(
                child: title
              ),
              (trailing != null) ? trailing! : const SizedBox(width: 5),
            ],
          ),
        ),
      
    );
  }
}
