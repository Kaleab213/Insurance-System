// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:pro/user/model/User_model.dart';

import '../model/auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}



class UpdateUserRoleEvent extends AuthEvent {
  final String role;
  final User user;

  UpdateUserRoleEvent(this.role, this.user);
  
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AuthLoad extends AuthEvent {
  const AuthLoad();

  @override
  List<Object> get props => [];
}
class ProfileLoad extends AuthEvent {
  const ProfileLoad();

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

class AuthLogout extends AuthEvent {
  

  const AuthLogout();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'logout from {Auth Id: ';
}

class UpdateAccount extends AuthEvent {
  final User user;

  const UpdateAccount(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Auth Created {Auth Id: ${user.email}';
}


class DeleteAccount extends AuthEvent {
  final Auth auth;

  const DeleteAccount(this.auth);

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'Auth Created {Auth Id: ${auth.email}';
}

