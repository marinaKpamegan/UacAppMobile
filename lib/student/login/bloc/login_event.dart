part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String identifiant;
  final String password;

  const LoginButtonPressed({
    @required this.identifiant,
    @required this.password
  });

  @override
  List<Object> get props => [identifiant, password];

  @override
  String toString() => 'LoginButtonPressed { username: $identifiant, password: $password }';
}
