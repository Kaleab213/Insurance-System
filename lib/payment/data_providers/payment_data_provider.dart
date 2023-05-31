import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../model/payment_model.dart';

class PaymentDataProvider {
  static const String baseUrl = "http://localhost:3300/api/v1/herds";

  Future<Payment> create(Payment payment) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "date": payment.date,
          "qrcode": payment.qrcode,
          "id": payment.id,
          "amount": payment.amount,
          "image": payment.image
        },
      ),
    );

    if (response.statusCode == 201) {
      return Payment.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Payment");
    }
  }

  Future<Payment> fetchOne(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Payment of id failed");
    }
  }

  Future<List<Payment>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      var saveData = jsonEncode(response.body);
      await prefs.setString('Payments', saveData);

      final payment = jsonDecode(response.body) as List;
      return payment.map((c) => Payment.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Payments");
    }
  }

  Future<Payment> update(String id, Payment payment) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "date": payment.date,
          "qrcode": payment.qrcode,
          "id": payment.id,
          "amount": payment.amount,
          "image": payment.image,
        },
      ),
    );

    if (response.statusCode == 200) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Payment");
    }
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
