// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:mocktail/mocktail.dart';

// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   group('AuthBloc', () {
//     late AuthRepository authRepository;
//     late AuthBloc authBloc;

//     setUp(() {
//       authRepository = MockAuthRepository();
//       authBloc = AuthBloc(authRepository: authRepository);
//     });

//     test('emits AuthLoading followed by AuthDataLoaded when AuthLogin is added', () async {
//       // Arrange
//       final user = User(email: 'fasika@gmail.com', password: 'password', firstName: 'fasika', lastName: '', id: '1', role: 'CUSTOMER');
//       when(() => authRepository.login(user as Auth)).thenAnswer((_) async => user);

//       // Act
//       authBloc.add(AuthLogin(user: user));
//       await untilCalled(() => authRepository.login(user));

//       // Assert
//       expect(
//         authBloc.stream,
//         emitsInOrder([
//           AuthLoading(),
//           AuthDataLoaded(user),
//         ]),
//       );
//     });

//     test('emits AuthLoading followed by AuthDataLoadingError when AuthLogin throws an error', () async {
//       // Arrange
//       final user = User(email: 'fasika@gmail.com', password: 'password', firstName: 'fasika', lastName: '', id: '1', role: 'CUSTOMER');
//       final error = Exception('Login failed');
//       when(() => authRepository.login(user)).thenThrow(error);

//       // Act
//       authBloc.add(AuthLogin(user: user));
//       await untilCalled(() => authRepository.login(user));

//       // Assert
//       expect(
//         authBloc.stream,
//         emitsInOrder([
//           AuthLoading(),
//           AuthDataLoadingError(error),
//         ]),
//       );
//     });

//     test('emits AuthLoading followed by AuthDataLoaded when AuthSignup is added', () async {
//       // Arrange
//       final user = User(email: 'fasika@gmail.com', password: 'password', firstName: 'fasika', lastName: '', id: '1', role: 'CUSTOMER');
//       when(() => authRepository.signup(user)).thenAnswer((_) async => user);

//       // Act
//       authBloc.add(AuthSignup(user: user));
//       await untilCalled(() => authRepository.signup(user));

//       // Assert
//       expect(
//         authBloc.stream,
//         emitsInOrder([
//           AuthLoading(),
//           AuthDataLoaded(user),
//         ]),
//       );
//     });

//     test('emits AuthLoading followed by AuthDataLoadingError when AuthSignup throws an error', () async {
//       // Arrange
//       final user = User(email: 'fasika@gmail.com', password: 'password', firstName: 'fasika', lastName: '', id: '1', role: 'CUSTOMER');
//       final error = Exception('Signup failed');
//       when(() => authRepository.signup(user)).thenThrow(error);

//       // Act
//       authBloc.add(AuthSignup(user: user));
//       await untilCalled(() => authRepository.signup(user));

//       // Assert
//       expect(
//         authBloc.stream,
//         emitsInOrder([
//           AuthLoading(),
//           AuthDataLoadingError(error),
//         ]),
//       );
//     });
//   });
// }
