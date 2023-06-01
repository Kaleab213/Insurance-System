import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/user/model/User_model.dart';

import '../repository/information_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoading()) {
  //   on<AuthLoad>(
  //     (event, emit) async {
  //       emit(AuthLoading());
  //       try {
  //         final auths = await authRepository.get_user();
  //         emit(AuthDataLoaded(auths as User));
  //       } catch (error) {
  //         emit(AuthDataLoadingError(error));
  //       }
  //     },
  //   );

    on<AuthLogin>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          User user = await authRepository.login(event.auth);
          emit(AuthDataLoaded(user));
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
          emit(AuthDataLoaded(user));
        } catch (error) {
          print(error);
          emit(AuthDataLoadingError(error));
        }
      },
    );
  }
}