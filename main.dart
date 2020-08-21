import 'package:dailymeet/chat.dart';
import 'package:dailymeet/login.dart';
import 'package:dailymeet/register.dart';
import 'package:flutter/material.dart';
import 'package:dailymeet/custom_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context){
          return MyHomePage();
        },
        Register.id: (context){
          return Register();
        },
        LogIn.id: (context){
          return LogIn();
        },
        Chat.id: (context){
          return Chat();
        },
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  static const String id ="HOMESCREEN";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: Padding(

        padding: EdgeInsets.only(top:240.0),
        child: Column(

          children: <Widget>[
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.cyan,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                SizedBox(width: 5.0,),
                Center(
                  child: Text('DailyMeet',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 40.0,
                  ),),
                )
              ],
            ),
            SizedBox(height: 50.0,),
            CustomButton(
              text: 'Log In',
              callback: (){
                Navigator.of(context).pushNamed(LogIn.id);
              },
            ),
            SizedBox(height: 20.0,),
            CustomButton(
              text: 'Register',
              callback: (){
                Navigator.of(context).pushNamed(Register.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
