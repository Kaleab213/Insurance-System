// import 'dart:io';

// import 'package:path/path.dart';

// // ignore: import_of_legacy_library_into_null_safe
// import 'package:sqflite/sqflite.dart';

// import '../../model/insurance_model.dart';


// class InsuranceDbHelper {
//   final int version = 1;
//   late Database db;
//   File? document;

//   static final InsuranceDbHelper _dbHelper = InsuranceDbHelper._internal();
//   InsuranceDbHelper._internal();
//   factory InsuranceDbHelper() {
//     return _dbHelper;
//   }

//   Future<Database> openDb() async {
//     db = await openDatabase(join(await getDatabasesPath(), 'Herd2.db'),
//         onCreate: (database, version) async {
//       await database.execute(
//           'CREATE TABLE IF NOT EXISTS Insurance(location Text, Document Text, size INT, room INT, type TEXT, level Text, id INT)');
//     }, version: version);

//     return db;
//   }

//   Future<int> insertInsurance(Insurance insurance) async {
//     print(insurance.toString());
//     return await db.insert(
//       'Insurance',
//       insurance.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> updateHerd(Insurance insurance) async {
//     print(insurance.level);
//     print("Updatinggg");
//     await db.update(
//       'Insurance',
//       insurance.toMap(),
//       where: "Herdids = ?",
//       whereArgs: [insurance.id],
//     );
//   }

//   Future<List<Insurance>> getInsuranceLists() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await db.query('Insurance');
//     return List.generate(
//       maps.length,
//       (i) {
//         return Insurance(
//           location: maps[i]["location"],
//           level: maps[i]["coveragelevel"],
//           size: maps[i]["size"],
//           type: maps[i]["propertytype"],
//           room: maps[i]["room"],
      
//           id: maps[i]["id"],
//           Document:document?.path
//    );
//       },
//     ).toList();
//   }

//   Future<int> deleteinsurance(String id) async {
//     int result = await db.delete("Insurance", where: "Insurance_id = ?", whereArgs: [id]);
//     print(result);
//     return result;
//   }
// }
