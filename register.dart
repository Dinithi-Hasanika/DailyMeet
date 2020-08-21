import 'package:dailymeet/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dailymeet/chat.dart';

class Register extends StatefulWidget {

  static const String id ="REGISTER";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async{

    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
            text: "Register",
            callback: ()async{
             await registerUser();
            },
          ),
          SizedBox(height: 5.0,),
        ],
      ),
    );
  }
}
