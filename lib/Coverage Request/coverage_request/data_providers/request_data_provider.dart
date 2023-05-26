import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request.dart';

class RequestDataProvider {
  static const String _baseUrl = "http://10.0.2.2:9191/api/v1/requests";

  Future<Request> create(Request request) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "coverage_id": request.coverage_id,
          "date": request.date,
          "police_report": request.police_report,
          "supporting_document": request.supporting_document,
          "description": request.description,
        }));

    if (response.statusCode == 201) {
      return Request.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create request");
    }
  }

  Future<Request> fetchByCode(String coverage_id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$coverage_id"));

    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Request by code failed");
    }
  }

  Future<List<Request>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final requests = jsonDecode(response.body) as List;
      return requests.map((c) => Request.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch requests");
    }
  }

  Future<Request> update(int coverage_id, Request request) async {
    final response = await http.put(Uri.parse("$_baseUrl/$coverage_id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "coverage_id": request.coverage_id,
          "date": request.date,
          "police_report": request.police_report,
          "supporting_document": request.supporting_document,
          "description": request.description
        }));

    if (response.statusCode == 200) {
      return Request.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the request");
    }
  }

  Future<void> delete(int coverage_id) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$coverage_id"));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete the request");
    }
  }
}
