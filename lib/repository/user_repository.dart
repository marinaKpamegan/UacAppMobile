import 'dart:async';
import 'package:uac_campus/dao/user_dao.dart';
import 'package:uac_campus/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:uac_campus/models/api_model.dart';
import 'package:uac_campus/api_connection/api_connection.dart';

class UserRepository {
  final userDao = /*UserDao()*/ null;

  Future<User> authenticate ({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(
        identifiant: username,
        password: password
    );
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      identifiant: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken ({
    @required User user
  }) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future <void> deleteToken({
    @required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}

