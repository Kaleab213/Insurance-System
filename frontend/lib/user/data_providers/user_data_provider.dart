import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
// import 'package:insurance_system/user/model/User_model.dart';

// import '../model/user_model.dart';
import 'package:http/http.dart' as http;



class UserDataProvider {
  static const String baseUrl = "http://localhost:3000/customer";

  Future<User> create(User user) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "firstName": user.firstName,
          "lastName": user.lastName,
          "password": user.password,
          "role": user.role,
          // "userName": user.userName,
          "email" : user.email,
          "phoneNumber" : user.phone,
          "accountNumber" : user.account_no,
          // "kebele" : user.kebele,
        },
      ),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create User");
    }
  }

  Future<User> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching User of id failed");
    }
  }

  Future<List<User>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      var saveData = jsonEncode(response.body);
      await prefs.setString('user', saveData);
      
      final user = jsonDecode(response.body) as List;
      return user.map((c) => User.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Users");
    }
  }

  Future<User> update(String id, User user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "fristName": user.firstName,
          "lastName": user.lastName,
          "password": user.password,
          "role": user.role,
          // "userName": user.userName,
          "email" : user.email,
          "phoneNumber" : user.phone,
          "accountNumber" : user.account_no,
          

        },
      ),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the User");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the user");
    }
  }
}
