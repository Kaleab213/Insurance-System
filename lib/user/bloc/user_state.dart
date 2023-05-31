import 'package:equatable/equatable.dart';

import '../model/User_model.dart';


abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserDataLoaded  extends UserState {
  final Iterable<User> users;

  const UserDataLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];
}

class UserDataLoadingError extends UserState {
  final Object error;

  const UserDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
