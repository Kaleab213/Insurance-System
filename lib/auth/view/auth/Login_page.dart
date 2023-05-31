import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/LocalStore/store.dart';
import 'package:pro/auth/bloc/auth_state.dart';
import 'package:pro/auth/view/auth/sign_up.dart';
// import 'package:pro/user/model/User_model.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../data_providers/auth_data_provider.dart';
import '../../model/auth.dart';
import '../../repository/information_repository.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthDataProvider authDataProvider = AuthDataProvider();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(authRepository: AuthRepository(authDataProvider)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthLoading) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ),
              );
            } else {
              if (state is AuthDataLoadingError) {
                print(state);
                print("for error debug");
                context.go("/error");
              } else {
                if (state is AuthDataLoaded) {
                  UserPreferences.email=state.user.email;
                  UserPreferences.role=state.user.role;
                  UserPreferences.userId=state.user.id;
                  print("for debug");
                  print(state.user);

                  context.go("/insuranceList");
                  // if (state.user.role == "CUSTOMER") {
                  //   context.go("/insuranceList");
                  // } else if (state.user.role == "ADMIN") {
                  //   context.go("/admininsuranceList");
                  // } else {
                  //   context.go("/signup");
                  // }
                }
              }
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Scaffold(
                body: Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon(),
                            const SizedBox(height: 40.0),
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'email',
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.black),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.black),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  )),
                            ),
                            const SizedBox(height: 40.0),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final AuthEvent event = AuthLogin(
                                    Auth(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      token:"",
                                    ),
                                  );

                                  BlocProvider.of<AuthBloc>(context).add(event);
                                  print(state);
                                  // print("email controller");
                                  // print(_emailController.text);
                                  // print(_passwordController.text);
                                }
                                _passwordController.clear();
                                _emailController.clear();
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            CreateAccount(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget icon() {
  return const Icon(Icons.person);
}

Widget CreateAccount(BuildContext context) {
  final AuthState state = context.watch<AuthBloc>().state;

  return GestureDetector(
    onTap: () {
      // if (state is Ay
      //uthDataLoaded) {
      //   if (state.user.Role == "user") {
      //     context.go("/signup");
      //   } else if (state.user.Role == "admin") {
      //     context.go("/adminsignup");
      //   }
      // } else {
      //   context.go("/signup");
      // }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    },
    child: Text(
      'Don\'t have an account? Sign up',
      style: TextStyle(
        color: Colors.black,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
