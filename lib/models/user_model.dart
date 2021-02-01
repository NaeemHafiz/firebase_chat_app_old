import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String selectedObjectKey;
  String ContactNumder;
  String Country;
  String Email;
  String FirstName;
  String LastName;
  String Password;
  int TimeZoneId;
  String UserName;

  UserModel();

  static List<UserModel> fromSnapshot(DataSnapshot dataValues) {
    List<UserModel> userList = [];
    dataValues.value.forEach((key, value) {
      var user = UserModel();
      user.selectedObjectKey = key;
      user.UserName = value["UserName"];
      user.Country = value["Country"];
      user.Email = value["Email"];
      user.FirstName = value["FirstName"];
      user.LastName = value["LastName"];
      user.Password = value["Password"];
      user.TimeZoneId = value["TimeZoneId"];
      user.ContactNumder = value["ContactNumder"];
      userList.add(user);
      print(userList.toString());
    });
    return userList;
  }

  toJson() {
    return {
      "ContactNumder": ContactNumder,
      "Country": Country,
      "Email": Email,
      "FirstName": FirstName,
      "LastName": LastName,
      "Password": Password,
      "TimeZoneId": TimeZoneId,
      "UserName": UserName,
    };
  }
}
