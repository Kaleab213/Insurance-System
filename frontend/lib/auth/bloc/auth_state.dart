import 'package:equatable/equatable.dart';


import 'auth_event.dart';
import '../../user/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthDataLoaded extends AuthState {
  final User user;
  final String userRole;

  const AuthDataLoaded(this.user, this.userRole);

  @override
  List<Object> get props => [user];
}

class ProfileDataLoaded extends AuthState {
  final User user;
  final String? userRole;
  
  const ProfileDataLoaded(this.user, this.userRole);

  @override
  List<Object> get props => [user];
}

class AuthDataLoadingError extends AuthState {
  final Object error;
  const AuthDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}



