import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class InsuranceDataProvider {
  final _baseUrl = 'Our URL';
  final http.Client httpClient;

  InsuranceDataProvider({required this.httpClient})
      : assert(httpClient != null);

  Future<Insurance> createInsurance(Insurance insurance) async {
    final response = await httpClient.post(
      Uri.http('OUR URL', '/insurances'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'size': insurance.size,
        'location': insurance.location,
        'numberOfRooms': insurance.numberOfRooms,
        'propertyType': insurance.propertyType,
        'coverageLevel': insurance.coverageLevel,
      }),
    );

    if (response.statusCode == 200) {
      return Insurance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create insurance.');
    }
  }

  Future<List<Insurance>> getInsurances() async {
    final response = await httpClient.get('$_baseUrl/insurances' as Uri);

    if (response.statusCode == 200) {
      final insurances = jsonDecode(response.body) as List;
      return insurances
          .map((insurance) => Insurance.fromJson(insurance))
          .toList();
    } else {
      throw Exception('Failed to load insurances');
    }
  }

  Future<void> deleteInsurance(Insurance insurance) async {
    final response = await httpClient.delete(
      '$_baseUrl/insurances/${insurance.location}' as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete insurance.');
    }
  }

  Future<void> updateInsurance(Insurance insurance) async {
    final response = await httpClient.put(
      '$_baseUrl/insurances/${insurance.location}' as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'size': insurance.size,
        'location': insurance.location,
        'numberOfRooms': insurance.numberOfRooms,
        'propertyType': insurance.propertyType,
        'coverageLevel': insurance.coverageLevel,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update insurance.');
    }
  }
}
