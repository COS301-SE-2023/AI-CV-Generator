import 'dart:convert';

UserModel userModelJson(String str) =>
  UserModel.fromJSON(json.decode(str));

String UserModeltoJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int userId;
    String fname;
    String lname;
    

    UserModel({required this.userId,required this.fname,required this.lname});

    factory UserModel.fromJSON(Map<String,dynamic> json) => UserModel(
      userId: json["userId"], 
      fname: json["fname"], 
      lname: json["lname"]
    );

    Map<String,dynamic> toJson() => {
      "fname":fname,
      "lname":lname,
      "userId": userId
    };

    String get fname_ => fname;
    String get lname_ => lname;
      
}