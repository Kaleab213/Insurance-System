// import 'package:path/path.dart';
// import 'package:pro/farm/model/model.dart';
// import 'package:sqflite/sqflite.dart';

// class DBclass {
//   final int version = 1;
//   late Database db;

//   static final DBclass _dbclass = DBclass._internal();
//   DBclass._internal();
//   factory DBclass() {
//     return _dbclass;
//   }

//   Future<Database> openDb() async {
//     db = await openDatabase(join(await getDatabasesPath(), 'HerdMaster.db'),
//         onCreate: (database, version) {
//       database.execute(
//           'CREATE TABLE FARM(id INTEGER PRIMARY KEY, inventory TEXT, userID TEXT, farmName TEXT, id_ TEXT)');
//     }, version: version);
//     return db;
//   }

//   Future<int> insertFrme(FARM farm) async {
//     int id = await db.insert(
//       'FARM',
//       farm.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     return id;
//   }

//   Future<int> updateFarm(FARM farm) async {
//     int id = await db.update(
//       'FARM',
//       farm.toMap(),
//       where: "id=?",
//       whereArgs: [farm.id],
//     );
//     return id;
//   }

//   Future<List<FARM>> getFarms() async {
//     final List<Map<String, dynamic>> maps = await db.query('FARM');
//     return List.generate(maps.length, (i) {
//       return FARM(
//         maps[i]['id'],
//         maps[i]['inventory'],
//         maps[i]['userID'],
//         maps[i]['farmName'],
//         maps[i]['id_'],
//       );
//     }).toList();
//   }

//   Future<int> deleteitem(FARM farm) async {
//     int result =
//         await db.delete("FARM", where: "id_ = ?", whereArgs: [farm.id_]);

//     return result;
//   }
// }
