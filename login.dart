import 'package:flutter/material.dart';
import 'package:dailymeet/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:dailymeet/chat.dart';


class LogIn extends StatefulWidget {

  static const String id ="LOGIN";

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logInUser() async{

    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(user: user,))
    )
    ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DailyMeet'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('assets/logo.png'),
                ),
              )
          ),
          SizedBox(height: 10.0,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val){
              setState(() {
                email = val;
              });
            },
            decoration: InputDecoration(
              hintText: 'Email',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0,),
          TextField(
            autocorrect: false,
            onChanged: (val){
              setState(() {
                password = val;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0,),
          CustomButton(
            text: "LogIn",
            callback: ()async{
              await logInUser();
            },
          ),
          SizedBox(height: 5.0,),
        ],
      ),
    );;
  }
}
