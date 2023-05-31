import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_exports.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<UserLoad>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchAll();
        emit(UserDataLoaded(users));
      } catch (error) {
        emit(UserDataLoadingError(error));
      }
    });

    on<UserCreate>(
      (event, emit) async {
        try {
          await userRepository.create(event.user);
          final users = await userRepository.fetchAll();
          emit(UserDataLoaded(users));
        } catch (error) {
          emit(UserDataLoadingError(error));
        }
      },
    );

    on<UserUpdate>((event, emit) async {
      try {
        await userRepository.update(event.id, event.user);
        final users = await userRepository.fetchAll();
        emit(UserDataLoaded(users));
      } catch (error) {
        emit(UserDataLoadingError(error));
      }
    });

    on<UserDelete>((event, emit) async {
      try {
        await userRepository.delete(event.id);
        final users = await userRepository.fetchAll();
        emit(UserDataLoaded(users));
      } catch (error) {
        emit(UserDataLoadingError(error));
      }
    });
  }
}
