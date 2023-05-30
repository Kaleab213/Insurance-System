import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/payment.dart';

class PaymentDataProvider {
  static const String _baseUrl = "http://10.0.2.2:9191/api/v1/rayments";

  Future<Payment> create(Payment payment) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "transactionId": payment.transactionId,
          "transactionImage": payment.transactionImage,
          "paymentAmount": payment.paymentAmount,
          "userId": payment.userId,
          "insuranceId": payment.insuranceId,
        }));

    if (response.statusCode == 201) {
      return Payment.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create payment");
    }
  }

  Future<Payment> fetchByCode(String transactionId) async {
    final response = await http.get(Uri.parse("$_baseUrl/$transactionId"));

    if (response.statusCode == 200) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Payment by id failed");
    }
  }

  Future<List<Payment>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final payments = jsonDecode(response.body) as List;
      return payments.map((c) => Payment.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch payments");
    }
  }
}
