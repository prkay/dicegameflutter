class LoginRequest {
  final String email;
  final String password;
  LoginRequest({this.email, this.password,});

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
        email: map["email"],
        password: map["password"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}