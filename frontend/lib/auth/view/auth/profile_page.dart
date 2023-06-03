import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:pro/auth/bloc/auth_event.dart';
import 'package:pro/auth/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileDataLoaded && state.userRole == "CUSTOMER") {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile Page',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('userData');

                    BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                    print(state);

                    context.go("/signin");
                  },
                  icon: const Icon(Icons.logout),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    // Navigate to the update user information page
                    context.go("/editprofile");
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    try {
                      final auth = Auth.fromJson(user.toJson());
                      BlocProvider.of<AuthBloc>(context)
                          .add(DeleteAccount(auth));
                      print(state);

                      context.go("/signup");
                    } catch (error) {
                      context.go("/error", extra: error);
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.firstName + " " + user.lastName),
                  subtitle: Text(user.email),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  label: 'Profile',
                ),
                
              ],
              currentIndex: 2,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: (int index) {
                if (index == 0) {
                  context.go('/insuranceList');
                } else if (index == 1) {
                  context.go('/notification');
                } else if (index == 2) {
                  context.go('/profile');
                } else if (index == 3) {
                  context.go('/requestList');
                }
              },
            ),
          );
        } else {
          if (state is AuthDataLoadingError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text(
                "Error",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
