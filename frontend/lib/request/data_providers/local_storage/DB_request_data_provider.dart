import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../model/request_model.dart';




class   RequestDbHelper {
  final int version = 1;
  late Database db;

  static final RequestDbHelper _dbHelper = RequestDbHelper._internal();
  RequestDbHelper._internal();
  factory RequestDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'Request.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Request(status BOOL, updatedAt TEXT, description TEXT, police_report TEXT, supported_document TEXT, loss DOUBLE , insured_payment DOUBLE , insuranceId INT, createdAt TEXT, FOREIGN KEY(insuranceId) REFERENCES Insurance(id) ON DELETE CASCADE)');
    }, version: version);
    return db;
  }

  Future<int> insertRequest(Request request) async {
    print(request.toString());
    return await db.insert(
      'Request',
      request.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRequest(Request request) async {

    await db.update(
      'Request',
      request.toMap(),
      where: "id = ?",
      whereArgs: [request.id],
    );
  }

  Future<List<Request>> getRequestLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Request');
    return List.generate(
      maps.length,
      (i) {
        return Request(
          updatedAt: maps[i]["updatedAt"],
          id: maps[i]["id"],
          police_report: maps[i]["police_report"],
          loss: maps[i]["loss"],
          insured_payment: maps[i]["insured_payment"],
          supported_document: maps[i]["supported_document"],
          description: maps[i]["coveragedescription"],
          status: maps[i]["status"] 
        );
      },
    ).toList();
  }

  Future<int> deleterequest(String id) async {
    int result = await db.delete("Request", where: "id = ?", whereArgs: [id]);
    // print(result);
    return result;
  }
}