import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/user/model/User_model.dart';

import '../../../auth/view/auth/sign_up.dart';
import '../../bloc/user_bloc.dart';
import '../../bloc/user_event.dart';
import '../../user_exports.dart';

class LoginPages extends StatelessWidget {
  LoginPages({super.key});

  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool validate() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final User myuser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<UserBloc, UserState>(
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
                          const SizedBox(height: 40.0),
                          _emailFormField(_emailController),
                          const SizedBox(height: 20.0),
                          _passwordFormField(_passwordController),
                          const SizedBox(height: 40.0),
                          ElevatedButton(
                            onPressed: () {
                              if (validate()) {
                                final UserEvent event = UserCreate(User(
                                  firstName: "",
                                  lastName: "",
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: "CUSTOMER",
                                  id: "",
                                  // kebele: "",
                                  // userName: "",
                                  phone: 0,
                                  account_no: 0,
                                 
                                ));
                                BlocProvider.of<UserBloc>(context).add(event);
                              }
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          CreateAccount(context)
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}



Widget _emailFormField(_emailController) {
  return TextFormField(
    controller: _emailController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your email';
      }
      return null;
    },
    decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email, color: Colors.black),
        labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
        )),
  );
}

Widget _passwordFormField(_passwordController) {
  return TextFormField(
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
        prefixIcon: Icon(Icons.lock, color: Colors.black),
        labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
        )),
  );
}

Widget CreateAccount(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    },
    child: const Text(
      'Don\'t have an account? Sign up',
      style: TextStyle(
        color: Colors.black,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
