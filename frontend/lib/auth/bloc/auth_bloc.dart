import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/user/model/user_model.dart';

import '../repository/information_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoading()) {
    on<AuthLoad>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final auths = await authRepository.get_user();
          final user = User.fromJson(
            jsonDecode(
              auths.toString(),
            ),
          );
          emit(AuthDataLoaded(user, user.role!));
        } catch (error) {
          emit(AuthDataLoadingError(error));
        }
      },
    );

    on<AuthLogin>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          User user = await authRepository.login(event.auth);

          emit(AuthDataLoaded(user, user.role!));
        } catch (error) {
          print("error in bloc");
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );

    on<AuthSignup>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await authRepository.signup(event.user);
          emit(AuthDataLoaded(user, user.role!));
        } catch (error) {
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );
    on<AuthLogout>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await authRepository.logout();
        } catch (error) {
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );

    on<UpdateAccount>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          print("before calling repo in update account bloc");
          User user = await authRepository.update_account(event.user);
          print("in update account cbloc user from repository");
          print(user);
          emit(ProfileDataLoaded(user, user.role));
          print("profile data emitted");
        } catch (error) {
          print("error in bloc");
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );
    on<DeleteAccount>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          bool user = await authRepository.delete_account();
        } catch (error) {
          print("error in bloc");
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );

    on<UpdateUserRoleEvent>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          User user = await authRepository.update_account(event.user);
        } catch (error) {
          print("error in bloc");
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );
  }
}

class ProfileBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  ProfileBloc({required this.authRepository}) : super(AuthLoading()) {
    on<ProfileLoad>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          String userData = (await authRepository.get_user());
          final user = User.fromJson(
            jsonDecode(
              userData.toString(),
            ),
          );
          emit(ProfileDataLoaded(user, user.role!));
        } catch (error) {
          print("error in bloc");
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );
  }
}
