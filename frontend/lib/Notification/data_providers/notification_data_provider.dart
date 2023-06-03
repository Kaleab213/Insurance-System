import 'dart:convert';
import 'dart:io';

import 'package:pro/Notification/model/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationDataProvider {
  static const String baseUrl = "http://localhost:3300/notification";

  Future<Notifications> create(Notifications notification) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "note": notification.note,
        },
      ),
    );

    if (response.statusCode == 201) {
      return Notifications.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Notification");
    }
  }

  Future<Notifications> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Notifications.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Notification of id failed");
    }
  }

  Future<List<Notifications>> fetchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final response = await http.get(Uri.parse(baseUrl),

    headers: <String, String>{
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },

    );
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var saveData = jsonEncode(response.body);
      await prefs.setString('Notifications', saveData);

      final notification = jsonDecode(response.body) as List;
      return notification.map((c) => Notifications.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Notifications");
    }
  }

  Future<Notifications> update(String id, Notifications notification) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "note": notification.note,
        },
      ),
    );

    if (response.statusCode == 200) {
      return Notifications.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Notification");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the Notification");
    }
  }
}
