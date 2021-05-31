import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        identifiant: _idController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Login Failed, try again'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset("assets/images/icons/cap-white.png", width: 80, height: 80, color: Color.fromRGBO(4, 57, 102, 1),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _idController,
                        style: TextStyle(color: Color.fromRGBO(4, 57, 102, 1)),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Color.fromRGBO(4, 57, 102, 1)),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Color.fromRGBO(4, 57, 102, 1), width: 1.0)

                          ),
                          labelText: "Identifiant",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: Color.fromRGBO(4, 57, 102, 1)),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Color.fromRGBO(4, 57, 102, 1)),
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Color.fromRGBO(4, 57, 102, 1), width: 1.0)
                          ),
                          // focusedBorder: InputBorder.none,
                          labelText: "Mot de passe",
                        ),
                        controller: _passwordController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      // width: MediaQuery.of(context).size.width-100,
                      height: 60,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          color: Color.fromRGBO(22, 129, 85, 1),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("CONNEXION", style: TextStyle(color: Colors.white),),
                          ),
                          onPressed: state is! LoginLoading
                              ? _onLoginButtonPressed
                              : null
                        // createLoginState(context, "toho.nick", "nickson");
                      ),
                    ),
                    Container(
                      child: Text("Mot de passe oublié?", style: TextStyle(color: Colors.redAccent),),
                    ),
                    Container(
                      child: state is LoginLoading
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
