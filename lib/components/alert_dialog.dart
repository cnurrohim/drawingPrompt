import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final String message;
  final String titleMessage;
  final bool? ok;
  final bool? cancel;
  final VoidCallback? okCallback;
  final VoidCallback? cancelCallback;

  // ignore: use_key_in_widget_constructors
  const ShowAlertDialog({
    required this.message,
    required this.titleMessage,
    this.ok,
    this.cancel,
    this.okCallback,
    this.cancelCallback
  });

  @override
  Widget build(BuildContext context) {

    final Widget okButton = TextButton(
      child: const Text('OK'),
      onPressed: okCallback,
    );

    final Widget cancelButton = TextButton(
      child: const Text('Cancel'),
      onPressed: (){Navigator.of(context).pop();},
    );

    List<Widget> _alertButtons(){
      List<Widget> buttons = [];
      if(cancel == true) {
        buttons.add(cancelButton);
      }
      if(ok == true) {
        buttons.add(okButton);
      }
      return buttons;
    }
    
    return AlertDialog(
      title: Text(titleMessage),
      content: Text(message),
      actions: _alertButtons()
    );
  }
}