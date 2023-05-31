import 'package:equatable/equatable.dart';

import '../model/User_model.dart';




abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  const UserLoad();

  @override
  List<Object> get props => [];
}

class UserCreate extends UserEvent {
  final User user;

  const UserCreate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Created {User Id: ${user.id}}';
}

class UserUpdate extends UserEvent {
  final String id;
  final User user;
  const UserUpdate(this.id, this.user);

  @override
  List<Object> get props => [id, user];

  @override
  String toString() => 'User Updated {User Id: ${user.id}}';
}

class UserDelete extends UserEvent {
  final String id;

  const UserDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'User Deleted {User Id: $id}';

  @override
  bool? get stringify => true;
}
