class User {
  int id;
  String identifiant;
  String token;

  User(
      {this.id,
      this.identifiant,
      this.token});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
      id: data['id'],
      identifiant: data['identifiant'],
      token: data['token'],
  );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "username": this.identifiant,
        "token": this.token
      };
}
