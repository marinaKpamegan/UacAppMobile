class Programme{
  int studentId;
  String status;
  int cycle;
  String registerAt;


  Programme(this.studentId, this.status, this.cycle, this.registerAt);


  Programme.all(this.studentId, this.status, this.cycle, this.registerAt);

  Programme.fromJson(Map<String, dynamic> json)
      : studentId = json['studentId'] as int,
        status = json['status'] as String,
        cycle = json['cycle'] as int,
        registerAt = json['registerAt'] as String;


  Map<String, dynamic> toJson()=>
      {
        "studentId": studentId,
        "status": status,
        "cycle": cycle,
        "registerAt": registerAt,
      };

}