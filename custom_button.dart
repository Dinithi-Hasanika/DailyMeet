import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          color: Colors.cyan,
          elevation: 6.0,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: callback,
            minWidth: 200.0,
            height: 45.0,
            child: Text(text,
            style:
              TextStyle(
                color: Colors.white
              ),),
          ),
        ),
    );
  }
}
