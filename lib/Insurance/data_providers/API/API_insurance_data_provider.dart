import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/insurance_model.dart';
import 'package:http/http.dart' as http;

class InsuranceDataProvider {
  static const String baseUrl = "http://localhost:3000/insurance";

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Insurance> create(Insurance insurance) async {
    // print(insurance.insuranceName);
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
          "size": insurance.size,
          "location": insurance.location,
          "Document": insurance.Document,
          "type": insurance.type,
          "level": insurance.level,
          "room": insurance.room,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Insurance.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Insurance");
    }
  }

  Future<Insurance> fetchOne(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Insurance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Insurance of id failed");
    }
  }

  Future<List<Insurance>> fetchAll() async {
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
    print("in fetch all insurance");
    print(response.body);
    if (response.statusCode == 200) {
      final List insurance = jsonDecode(response.body.toString()) as List;
      insurance.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Insurance> insurancelist = insurance
          .map(
            (c) => Insurance.fromJson(c),
          )
          .toList();
      return insurancelist;
    } else {
      throw Exception("Could not fetch insurances");
    }
  }

  Future<Insurance> update(int id, Insurance insurance) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "size": insurance.size,
          "location": insurance.location,
          "Document": insurance.Document,
          "type": insurance.type,
          "level": insurance.level,
          "room": insurance.room,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Insurance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the insurance");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the insurance");
    }
  }

Future<List<Insurance>> fetchAllforAdmin() async {
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
      final List insurance = jsonDecode(response.body.toString()) as List;
      insurance.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Insurance> insurancelist = insurance
          .map(
            (c) => Insurance.fromJson(c),
          )
          .toList();
      return insurancelist;
    } else {
      throw Exception("Could not fetch insurances");
    }
  }

}


