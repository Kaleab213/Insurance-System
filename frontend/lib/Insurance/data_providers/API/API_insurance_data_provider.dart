import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/insurance_model.dart';
import 'package:http/http.dart' as http;

class InsuranceDataProvider {
  static const String baseUrl = "http://192.168.43.218:3000/insurance";

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Insurance> create(Insurance insurance) async {
    print("in insurance create");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    final request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    // final requestBody = {'size': insurance.size, 'room': insurance.room};
    request.fields["location"] = insurance.location;
    request.fields["size"] = insurance.size.toString();
    request.fields["room"] = insurance.room.toString();
    request.fields["level"] = insurance.level;
    request.fields["type"] = insurance.type;
    // final encoded = jsonEncode(requestBody);
    // request.fields['size'] = encoded['size'];


    request.headers.addAll(
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});

    Future<Uint8List> fileToUint8List(File file) async {
      final bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    }

    if (insurance.Document != null) {
      final file = insurance.Document;

      // Read the file as a byte array
      final bytes = await fileToUint8List(file);

      final fileName = file.path.split('/').last;

      final multipartFile = http.MultipartFile.fromBytes(
        'Document',
        bytes,
        filename: fileName,
      );

      request.files.add(multipartFile);
    }

// mobile part
    // if (insurance.Document != null) {
    //   final file = insurance.Document;
    //   final fileName = file.path.split('/').last;
    //   final fileStream = http.ByteStream(file.openRead());
    //   final fileLength = await file.length();

    //   final multipartFile = http.MultipartFile(
    //     'Document',
    //     fileStream,
    //     fileLength,
    //     filename: fileName,
    //   );

    //   request.files.add(multipartFile);
    // }
    print("befor respons in insurance create");
    print(request.fields);
    final response = await request.send();
    print(response);
    print("after response in insurance create");
    final responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 201) {
      return Insurance.fromJson(jsonDecode(responseBody));
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
        io.HttpHeaders.authorizationHeader: 'Bearer $token'
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
      Uri.parse("$baseUrl/admin/get"),
      headers: <String, String>{
        "Content-Type": "application/json",
        io.HttpHeaders.authorizationHeader: 'Bearer $token'
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
