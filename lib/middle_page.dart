

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_campus/menu.dart';
import 'package:uac_campus/repository/user_repository.dart';
import 'package:uac_campus/student/about_identity_pages/student_fiche.dart';
import 'package:uac_campus/student/login/login_page.dart';

import 'bloc/authentication_bloc.dart';
import 'common/loading_indicator.dart';

class MiddlePage extends StatelessWidget{
  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
            userRepository: userRepository
        )..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    );
  }

}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return Menu();
          }
          if (state is AuthenticationAuthenticated) {
            return StudentFiche();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository,);
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}