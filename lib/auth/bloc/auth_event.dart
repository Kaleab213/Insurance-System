import 'package:equatable/equatable.dart';
import 'package:pro/user/model/User_model.dart';

import '../model/auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoad extends AuthEvent {
  const AuthLoad();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final Auth auth;

  const AuthLogin(this.auth);

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'Auth Created {Auth Id: ${auth.email}';
}

class AuthSignup extends AuthEvent {
  final User user;

  const AuthSignup(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Auth Created {Auth Id: ${user}';
}

