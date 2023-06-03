import 'dart:io';

import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../model/insurance_model.dart';

class InsuranceDbHelper {
  final int version = 1;
  late Database db;

  static final InsuranceDbHelper _dbHelper = InsuranceDbHelper._internal();
  InsuranceDbHelper._internal();
  factory InsuranceDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'Insurance.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Insurance(userId INT, location Text, propertytype Text, id INT, room INT,  size INT, Document TEXT, coveragelevel TEXT, deposit DOUBLE, telebirr_QR TEXT, status BOOL, monthly_payment DOUBLE)');
    }, version: version);

    return db;
  }

  Future<int> insertInsurance(Insurance insurance) async {
    print("in insert insurance");
    print(insurance.toString());
    return await db.insert(
      'Insurance',
      insurance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateInsurance(Insurance insurance) async {
    print("in update insurance");
    print(insurance);
    await db.update(
      'Insurance',
      insurance.toMap(),
      where: "id = ?",
      whereArgs: [insurance.id],
    );
  }

  Future<List<Insurance>> getInsuranceLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Insurance');
    print(maps);
    return List.generate(
      maps.length,
      (i) {
        return Insurance(
            location: maps[i]["location"],
            id: maps[i]["id"],
            type: maps[i]["propertytype"],
            room: maps[i]["room"],
            // coverage_request: [],
            size: maps[i]["size"],
            Document: File(maps[i]["Document"]),
            level: maps[i]["coveragelevel"],
            // telebirr_QR: File(maps[i]["telebirr_QR"]),
            deposit: maps[i]["deposit"],
            status: maps[i]["status"]);
      },
    ).toList();
  }

  Future<int> deleteinsurance(String id) async {
    int result = await db.delete("Insurance", where: "id = ?", whereArgs: [id]);
    // print(result);
    return result;
  }
}
