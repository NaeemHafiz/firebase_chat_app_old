import 'file:///C:/Users/qamer/Desktop/firebase_chat_app_old/lib/screens/chat_creen.dart';
import 'package:firebase_chat_app/constants.dart';
import 'file:///C:/Users/qamer/Desktop/firebase_chat_app_old/lib/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {
  final ScrollController listScrollController = ScrollController();
  var dbRef;
  List<UserModel> userList = [];
  String selectedObjectKey;

  User() {
    dbRef = FirebaseDatabase.instance
        .reference()
        .child(Constant.USER_TABLE)
        .orderByChild(Constant.USER_NAME);
  }

  @override
  Widget build(BuildContext context) {
    // <1> Use FutureBuilder
    return StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            userList.clear();
            DataSnapshot dataValues = snapshot.data.snapshot;
            userList = UserModel.fromSnapshot(dataValues);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildUserList(index, context);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildUserList(int index, BuildContext buildContext) {
    return GestureDetector(
        // read the index key
        onTap: () {
          selectedObjectKey = userList[index].selectedObjectKey;
          print("Selected User Key: " + selectedObjectKey);
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
                  child:
                      Text("User Name: " + userList[index].UserName.toString()),
                )
              ],
            ),
          ),
        ));
  }
}
