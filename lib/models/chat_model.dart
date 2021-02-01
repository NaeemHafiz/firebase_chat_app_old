import 'package:firebase_database/firebase_database.dart';

class ChatModel {

  String selectedObjectKey;
  String Message;
  String Optional;
  String ReceiverId;
  String ReceiverName;
  String SenderId;
  String SenderName;
  bool IsRead;
  int Date;

  ChatModel();

  static List<ChatModel> fromSnapshot(DataSnapshot dataValues) {
    List<ChatModel> chatList = [];
    dataValues.value.forEach((key, value) {
      var chatModel = ChatModel();
      chatModel.selectedObjectKey = key;
      chatModel.Message = value["Message"];
      chatModel.Optional = value["Optional"];
      chatModel.ReceiverId = value["ReceiverId"];
      chatModel.ReceiverName = value["ReceiverName"];
      chatModel.SenderId = value["SenderId"];
      chatModel.SenderName = value["SenderName"];
      chatModel.IsRead = value["IsRead"];
      chatModel.Date = value["Date"];
      chatList.add(chatModel);
    });
    return chatList;
  }
}
