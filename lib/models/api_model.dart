class UserLogin {
  String identifiant;
  String password;

  UserLogin({this.identifiant, this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "identifiant": this.identifiant,
    "password": this.password
  };
}

class Token{
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}

