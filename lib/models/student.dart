
class Student{
  int matricule;
  String identifiant;
  String nomFamille;
  String prenom;
  String email;
  String password;
  String sexe;


  Student(this.matricule, this.identifiant, this.nomFamille, this.prenom, this.sexe);


  Student.all(this.matricule, this.identifiant, this.nomFamille, this.prenom,
      this.email, this.password, this.sexe);

  Student.fromJson(Map<String, dynamic> json)
      : matricule = json['matricule'] as int,
        identifiant = json['identifiant'] as String,
        nomFamille = json['nomFamille'] as String,
        prenom = json['prenom'] as String,
        email = json['email'] as String,
        sexe = json['sexe'] as String,
        password = json['password'] as String;


  Map<String, dynamic> toJson()=>
      {
        "matricule": matricule,
        "identifiant": identifiant,
        "nomFamille": nomFamille,
        "prenom": prenom,
        "email": email,
        "sexe": sexe,
        "password": password
      };

/*@override
  String toString() {
    return '{ ${this.name}, ${this.description}, ${this.type}, ${this.location.latitude}, ${this.location.longitude}  }';
  }*/
}

class LoginResponse {
  String value;
  String expirationDateTime;
  int studentId;
  String updateDateTime;

  LoginResponse(
      {this.value, this.expirationDateTime, this.studentId, this.updateDateTime});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    expirationDateTime = json['expirationDateTime'];
    studentId = json['studentId'];
    updateDateTime = json['updateDateTime'];
  }
}

