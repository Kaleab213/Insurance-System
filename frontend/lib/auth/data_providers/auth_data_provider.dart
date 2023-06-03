import 'dart:convert';
import 'dart:io';
import 'package:pro/auth/bloc/auth_state.dart';
import 'package:pro/user/model/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../model/auth.dart';

class AuthDataProvider {
  static const String baseUrl = "http://192.168.43.218:3000/user";

  Future<User> post_login(Auth auth) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/signin"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "password": auth.password,
          "email": auth.email,
        },
      ),
    );

    print("Response Body check for role: ${response.body}");
    // print(response.body);

    if (response.statusCode == 201) {
      var x = Auth.fromJson(jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', x.token!);
      print("signin token");

      print(x.token);

      var user_detail = await get();
      print("here after detail");
      print(user_detail);
      Map<String, dynamic> jsonMap = jsonDecode(user_detail);
      String myrole = jsonMap['role'];

      // if (myrole == 'CUSTOMER') {
      final user = User.fromJson(
        jsonDecode(
          user_detail.toString(),
        ),
      );
      print("this is user");
      // await prefs.setString("user", user.toString());
      // return user;
      // } else {
      //   final user = Admin.fromJson(
      //     jsonDecode(
      //       user_detail.toString(),
      //     ),
      //   );
      //   await prefs.setString("user", user.toString());
      // }

      // print(jsonDecode(user_detail).runtimeType);
      // final user = User.fromJson(jsonDecode(userDetail));
      // final user = User.fromJson(
      //   jsonDecode(
      //     user_detail.toString(),
      //   ),
      // );
      print("here after user");
      // await prefs.setString("user", jsonDecode(user.toJson()));
      await prefs.setString("user", user.toString());
      print(user);
      print("I like");
      return user;
      // print(user.toString());
    } else {
      print("Login Failed: ${response.statusCode}");
      throw Exception("No User Found");
    }
  }

  // ignore: non_constant_identifier_names
  Future<User> post_signup(User user) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/customer/signup"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "password": user.password,
          "email": user.email,
          "role": "CUSTOMER",
          "firstName": user.firstName,
          "lastName": user.lastName,
        },
      ),
    );
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);

      var x = Auth.fromJson(jsonResponse);
      var token = x.token;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);
      var user_detail = await get();

      final user = User.fromJson(
        jsonDecode(
          user_detail.toString(),
        ),
      );
      await prefs.setString("user", user.toString());

      return user;
    } else {
      throw Exception("No User Found");
    }
  }

  Future<User> update_account(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    final http.Response response = await http.patch(
      Uri.parse("$baseUrl"),
      headers: <String, String>{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(
        {
          "password": user.password,
          "email": user.email,
          "role": "CUSTOMER",
          "firstName": user.firstName,
          "lastName": user.lastName,
        },
      ),
    );
    print("in update account");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var x = Auth.fromJson(jsonResponse);
      var token = x.token;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);
      await prefs.setString("user", user.toString());
      print("in update account user");
      print(user.toString());

      return user;
    } else {
      const AuthDataLoadingError("can not update account");
      throw (Exception("no account update"));
    }
  }

  Future<String> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    print("get token");
    print(token);
    final response = await http.get(
      Uri.parse("$baseUrl"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print("here in get");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fetching Auth of id failed");
    }
  }

  Future<String> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    print("get token");
    print(token);
    final response = await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // print("here in get");
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("logout unsuccesfull");
    }
  }

  Future<bool> delete_account() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    print("get token");
    print(token);
    final response = await http.delete(
      Uri.parse("$baseUrl"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // print("here in get");
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("delete account unsuccesfull");
    }
  }
}
