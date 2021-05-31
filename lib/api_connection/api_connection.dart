import 'dart:async';
import 'dart:convert';
import 'package:uac_campus/models/api_model.dart';
import 'package:http/http.dart' as http;

final _base = "http://2cde4d8f3efc.ngrok.io/okapiSimulator-1.0-SNAPSHOT/api";
final _tokenEndpoint = "/auth/";
final _tokenURL = _base + _tokenEndpoint;
var url = Uri.parse('https://example.com/whatsit/create');

Future<Token> getToken(UserLogin userLogin) async {
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
