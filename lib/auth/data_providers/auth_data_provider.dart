import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user/model/User_model.dart';
import 'package:http/http.dart' as http;

import '../model/auth.dart';

class AuthDataProvider {
  static const String baseUrl = "http://localhost:3000/user";

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

    print("Response Body: ${response.body}");

    if (response.statusCode == 201) {
      var x = Auth.fromJson(jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', x.token!);

      var user_detail = await get();
      // print("here after detail");
      // print(user_detail);
      // print(jsonDecode(user_detail).runtimeType);
      // final user = User.fromJson(jsonDecode(userDetail));
      final user = User.fromJson(
        jsonDecode(
          user_detail.toString(),
        ),
      );
      // print("here after user");
      // await prefs.setString("user", jsonDecode(user.toJson()));
      await prefs.setString("user", user.toString());
      // print(user.toString());
      return user;
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
          "phone": user.phone.toString(),
          "account_no": user.account_no.toString()

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
      await prefs.setString("user", jsonEncode(user));

      return user;
    } else {
      throw Exception("No User Found");
    }
  }

  Future<String> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final response = await http.get(
      Uri.parse("$baseUrl"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // print("here in get");
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fetching Auth of id failed");
    }
  }
}
