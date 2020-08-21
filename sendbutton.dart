import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {

  final VoidCallback callback;
  final String text;

  const SendButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      color: Colors.cyan,
      child: Text(
        text
      ),
    );
  }
}
