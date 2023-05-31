import 'dart:convert';

import 'package:pro/request/model/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/Herd_model.dart';
import 'package:http/http.dart' as http;

class RequestDataProvider {
  static const String baseUrl = "http://localhost:3300/api/v1/herds";

  Future<Request> create(Request request) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "description": request.description,
          "date": request.date,
          "policeReport": request.policeReport,
        },
      ),
    );

    if (response.statusCode == 201) {
      return Request.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Request");
    }
  }

  Future<Request> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Request of id failed");
    }
  }

  Future<List<Request>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      var saveData = jsonEncode(response.body);
      await prefs.setString('Requests', saveData);

      final request = jsonDecode(response.body) as List;
      return request.map((c) => Request.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Requests");
    }
  }

  Future<Request> update(String id, Request request) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          {
          "description": request.description,
          "date": request.date,
          "policeReport": request.policeReport,
        },
        },
      ),
    );

    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Request");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
