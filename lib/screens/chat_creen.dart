import 'file:///C:/Users/qamer/Desktop/firebase_chat_app_old/lib/models/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat_app/constants.dart';

class ChatScreen extends StatelessWidget {
  final ScrollController listScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  var dbRef;
  List<ChatModel> chatList = [];

  ChatScreen() {
    dbRef = FirebaseDatabase.instance
        .reference()
        .child(Constant.CHAT_TABLE)
        .orderByChild(Constant.CHAT_TABLE_DATE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder(
              stream: dbRef.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  chatList.clear();
                  DataSnapshot dataValues = snapshot.data.snapshot;
                  chatList = ChatModel.fromSnapshot(dataValues);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildChatList(index, context);
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: TextFormField(
              cursorColor: Colors.black,
              validator: (value) =>
                  value.isEmpty ? 'Message cannot be blank' : null,
              controller: textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a Message...'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: FlatButton(
              child: Text("Send Message"),
              onPressed: () {
                sendMessage();
                textEditingController.text = "";
              },
              textColor: Colors.white,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChatList(int index, BuildContext buildContext) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            buildContext,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Container(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Message: " + chatList[index].Message),
                )
              ],
            ),
          ),
        ));
  }

  sendMessage() {
    FirebaseDatabase.instance
        .reference()
        .child("Chat")
        .push()
        .set({"Message": textEditingController.text});
  }
}
