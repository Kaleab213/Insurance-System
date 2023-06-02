import 'package:equatable/equatable.dart';

import '../../user/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthDataLoaded extends AuthState {
  final User user;

  const AuthDataLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class AuthDataLoadingError extends AuthState {
  final Object error;
  const AuthDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
