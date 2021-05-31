import 'package:uac_campus/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class StudentService{
  // get
  Future<Student> fetchStudent() async {
    var url = Uri.parse('');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student information');
    }
  }

  //

}