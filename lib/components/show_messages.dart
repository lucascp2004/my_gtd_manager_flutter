import 'package:flutter/material.dart';

import 'message_dialog.dart';

class ShowMessages {
  static Future<void> showMessage(
      String text, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          
          return MessageDialog(text);
        });
  }
  static Future<void> showMessageAndPop(String text, BuildContext context) async{
    await showDialog(
      context: context, 
      builder: (context){
        return MessageDialog(text);
      }).then((_) {
        if (context.mounted) Navigator.pop(context);
      });
  }

  static void messageSnackBar(String error, BuildContext context) {
    final snackBar = SnackBar(
      duration:const Duration(seconds: 30),
      content: Text(error,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
