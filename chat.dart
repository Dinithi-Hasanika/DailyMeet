import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymeet/message.dart';
import 'package:dailymeet/sendbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat extends StatefulWidget {
  static const String id ="CHAT";
  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if(messageController.text.length >0){
      await _firestore.collection('Messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });

      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,curve: Curves.easeOut,duration:const Duration(microseconds: 300));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.cyan,
          backgroundImage: AssetImage('assets/logo.png'),
        ),
        title: Text('DailyMeet'),
        backgroundColor: Colors.cyan,
        actions: <Widget>[
       IconButton(
         icon: Icon(Icons.close),
         onPressed: (){
           _auth.signOut();
           Navigator.of(context).popUntil((route)=> route.isFirst);
         },
       ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
               stream: _firestore.collection('Messages').orderBy("date").snapshots(),
               builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }else{
                   List<DocumentSnapshot> docs = snapshot.data.documents;
                   
               List<Widget> messages = docs.map((doc) =>Message(
                 from: doc.data['from'],
                 text: doc.data['text'],
                 me: widget.user.email == doc.data['from'],
               )).toList();
                   return ListView(
                     controller: scrollController,
                     children: <Widget>[
                       ...messages,
                     ],
                   );
                 }
               },
             ),
           ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type A Text',
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted:(val) => callback,
                    ),
                  ),
                  SendButton(
                    text: 'Send',
                    callback: callback,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
