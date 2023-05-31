import 'dart:convert';
import 'dart:io';

import 'package:pro/request/model/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../model/request_model.dart';
import 'package:http/http.dart' as http;

class RequestDataProvider {
  static const String baseUrl = "http://localhost:3000/request";

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Request> create(Request request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final http.Response response = await http.post(
      Uri.parse("$baseUrl"),
      headers: <String, String>{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(
        {
          "description": request.description,
          "loss": request.loss,
          "police_report": request.police_report,
          "supported_documnet": request.supported_document,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Request.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Request");
    }
  }

  Future<Request> fetchOne(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Request of id failed");
    }
  }

  Future<List<Request>> fetchAll() async {
    // final response = await http.get(Uri.parse(baseUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final http.Response response = await http.get(
      Uri.parse("$baseUrl"),
      headers: <String, String>{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    print("in fetch all request");
    print(response.body);
    if (response.statusCode == 200) {
      final List request = jsonDecode(response.body.toString()) as List;
      request.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Request> requestlist = request
          .map(
            (c) => Request.fromJson(c),
          )
          .toList();
      return requestlist;
    } else {
      throw Exception("Could not fetch requests");
    }
  }

  Future<Request> update(int id, Request request) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "description": request.description,
          "loss": request.loss,
          "police_report": request.police_report,
          "supported_documnet": request.supported_document,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the request");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the request");
    }
  }

Future<List<Request>> fetchAllforAdmin() async {
    // final response = await http.get(Uri.parse(baseUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/admin"),
      headers: <String, String>{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    print("in fetch all admin");
    print(response.body);
    if (response.statusCode == 200) {
      final List request = jsonDecode(response.body.toString()) as List;
      request.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Request> requestlist = request
          .map(
            (c) => Request.fromJson(c),
          )
          .toList();
      return requestlist;
    } else {
      throw Exception("Could not fetch requests");
    }
  }

}


