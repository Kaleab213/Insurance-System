import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/auth/bloc/auth_event.dart';
import 'package:pro/user/model/user_model.dart';

// import '../../../screens/Home.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';

class AdminSignUpPage extends StatelessWidget {
  AdminSignUpPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final TextEditingController _FirstnameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _kebeleController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passswordConfirmationController =
      TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthDataLoadingError) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text("Change the email"),
                ),
              ),
            ),
          );
        } else {
          if (state is AuthLoading) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            context.go("/insuranceList", extra: state);
          }
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Color.fromARGB(255, 99, 237, 232),
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _FirstnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _LastnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Last Name',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            // TextFormField(
                            //   controller: _userNameController,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Please enter your username';
                            //     }
                            //     return null;
                            //   },
                            //   decoration: const InputDecoration(
                            //       labelText: 'Username',
                            //       prefixIcon: Icon(Icons.person)),
                            // ),
                            // const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your email address";
                                }
                                if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _passswordConfirmationController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please confirm your password";
                                }
                                if (value != _passwordController.text) {
                                  return "password must be same";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock)),
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller: _accountNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your account number";
                                }
                                if (!RegExp(r"^[0-9]{9,18}$").hasMatch(value)) {
                                  return "Please enter a valid account number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Account Number',
                                prefixIcon: Icon(Icons.account_balance),
                              ),
                            ),
                            // const SizedBox(height: 25.0),
                            // TextFormField(
                            //   controller: _kebeleController,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "Please enter your kebele name";
                            //     }
                            //     if (!RegExp(r"^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$").hasMatch(value)) {
                            //       return "Please enter a valid kebele name";
                            //     }
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.text,
                            //   decoration: const InputDecoration(
                            //     labelText: 'Kebele Name',
                            //     prefixIcon: Icon(Icons.location_city),
                            //   ),
                            // ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                                controller: _phoneNumberController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your phone number";
                                  }
                                  if (!RegExp(r"^\+?[1-9]\d{1,14}$").hasMatch(value)) {
                                    return "Please enter a valid phone number";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                              ),
                              const SizedBox(height: 25.0),
                            TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthEvent event = AuthSignup(
                                      User(
                                          firstName: _FirstnameController.text,
                                          password: _passwordController.text,
                                          lastName: _LastnameController.text,
                                          // userName: _userNameController.text,
                                          role: "ADMIN",
                                          id: "",
                                          email: _emailController.text,
                                          // kebele/: _kebeleController.text,
                                          ),
                                    );
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(event);
                                  }
                                },
                                child: const Text("SignUp"))
                          ],
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
