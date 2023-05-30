import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class NotificationDataProvider {
  static const String _baseUrl = "http://10.0.2.2:9191/api/v1/rotifications";

  Future<Notification> create(Notification notification) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "notificationId": notification.notificationId,
          "qrcodeImage": notification.qrcodeImage,
          "paymentAmount": notification.paymentAmount,
          "userId": notification.userId,
        }));

    if (response.statusCode == 201) {
      return Notification.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create notification");
    }
  }

  Future<Notification> fetchByCode(String notificationId) async {
    final response = await http.get(Uri.parse("$_baseUrl/$notificationId"));

    if (response.statusCode == 200) {
      return Notification.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching notification by id failed");
    }
  }

  Future<List<Notification>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final notifications = jsonDecode(response.body) as List;
      return notifications.map((c) => Notification.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch notifications");
    }
  }
}
