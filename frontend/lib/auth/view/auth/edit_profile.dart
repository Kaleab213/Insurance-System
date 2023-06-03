import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../user/model/User_model.dart';
import '../../../user/model/user_model.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, AuthState>(
      builder: (context, state) {
        final user = (state is ProfileDataLoaded) ? state.user : null;

        if (user != null) {
          _firstNameController.text = user.firstName;
          _lastNameController.text = user.lastName;
          _emailController.text = user.email;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // Save changes
                    final firstName = _firstNameController.text;
                    final lastName = _lastNameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    // Create an updated user object
                    final updatedUser = await User(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                      password: password,
                    );

                    BlocProvider.of<AuthBloc>(context)
                        .add(UpdateAccount(updatedUser));
                    
                    context.go("/profile");
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
