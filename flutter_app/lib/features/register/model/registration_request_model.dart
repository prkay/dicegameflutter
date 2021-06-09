
import 'dart:convert';

class UserModel {
  final String email;
  final String password;
  final String name;
  final int numberOfGame;
  final int totalPoints;
  UserModel({this.email, this.password, this.name,this.numberOfGame,this.totalPoints});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"],
      password: map["password"],
      name: map["name"],
      numberOfGame: map["total_game"],
      totalPoints: map["total_point"]
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = email;
    map["password"] = password;
    map["name"] = name;
    map["total_point"] = totalPoints;
    map["total_game"] = numberOfGame;
    return map;
  }
  static String encodeUserData(List<UserModel> userdata) => json.encode(
    userdata
        .map<Map<String, dynamic>>((userdata) => userdata.toMap())
        .toList(),
  );

  static List<UserModel> decodeUserData(String userdata) =>
      (json.decode(userdata) as List<dynamic>)
          .map<UserModel>((item) => UserModel.fromMap(item))
          .toList();
}