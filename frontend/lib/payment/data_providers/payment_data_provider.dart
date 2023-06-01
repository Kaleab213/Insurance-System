import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import '../model/payment_model.dart';

class PaymentDataProvider {
  static const String baseUrl = "http://localhost:3000/insurance";

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Payment> create(Payment payment) async {
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
          "ammount": payment.ammount,
          "bill": payment.bill,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Payment.fromJson(jsonDecode(response.body));
    }

    {
      throw Exception("Failed to create Payment");
    }
  }

  Future<Payment> fetchOne(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Payment of id failed");
    }
  }

  Future<List<Payment>> fetchAll() async {
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
    print("in fetch all payment");
    print(response.body);
    if (response.statusCode == 200) {
      final List payment = jsonDecode(response.body.toString()) as List;
      payment.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Payment> paymentlist = payment
          .map(
            (c) => Payment.fromJson(c),
          )
          .toList();
      return paymentlist;
    } else {
      throw Exception("Could not fetch payments");
    }
  }

  Future<Payment> update(int id, Payment payment) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "ammount": payment.ammount,
          "bill": payment.bill,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the payment");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the payment");
    }
  }

Future<List<Payment>> fetchAllforAdmin() async {
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
      final List payment = jsonDecode(response.body.toString()) as List;
      payment.map((e) => {
            print(e.toString()),
          });
      print("after map");
      final List<Payment> paymentlist = payment
          .map(
            (c) => Payment.fromJson(c),
          )
          .toList();
      return paymentlist;
    } else {
      throw Exception("Could not fetch payments");
    }
  }

}

