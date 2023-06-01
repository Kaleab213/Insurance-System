// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// // import '../issue/models/issueModel.dart';
// // import '../report/models/report_model.dart';
// // import '../schedule/models/schedule.dart';
// // import '../vehicle/models/vehicle_model.dart';

// class LocalDb {
//   final int version = 1;
//   Database? db;

//   static final LocalDb _dbHelper = LocalDb._internal();
//   LocalDb._internal();
//   factory LocalDb() {
//     return _dbHelper;
//   }

//   Future<Database> openDb() async {
//     db ??= await openDatabase(join(await getDatabasesPath(), 'vevalet.db'),
//         onCreate: (database, version) {
//       database.execute(
//           'CREATE TABLE schedules(_id INT PRIMARY KEY, firstName TEXT, lastName TEXT, vehicle_id TEXT, image TEXT, license_plate_number TEXT, start TEXT, end TEXT)');
//       database.execute(
//           'CREATE TABLE vehicles(_id TEXT PRIMARY KEY, manager_id TEXT, name TEXT, license_plate_number TEXT, image TEXT)');
//       database.execute(
//           'CREATE TABLE reports(_id TEXT PRIMARY KEY, driver_id TEXT, driver_name TEXT, manager_id TEXT, vehicle_name TEXT, distance TEXT, price TEXT, litres TEXT)');
//       database.execute(
//           'CREATE TABLE issues(_id TEXT PRIMARY KEY, driver_id TEXT, driver_name TEXT, manager_id TEXT, response TEXT, content TEXT, status TEXT)');
//     }, version: version);

//     return db!;
//   }

//   Future<void> saveSchedules(List<Map<String, dynamic>> jsonData) async {
//     await openDb();
//     await db!.delete('schedules');
//     final batch = db!.batch();
//     for (final json in jsonData) {
//       Map<String, dynamic> map = {};
//       map['_id'] = json["_id"];
//       map['driver_id'] = json["driver_id"];
//       map['manager_id'] = json["manager_id"];
//       map['vehicle_id'] = json["vehicle_id"];
//       map['image'] = json["image"];
//       map['license_plate_number'] = json["license_plate_number"];
//       map['start'] = json["start"];
//       map['end'] = json["end"];
//       batch.insert('schedules', map);
//     }
//     await batch.commit();
//   }

//   Future<List<Schedule>> getSchedules() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await db!.query('schedules');

//     return List.generate(maps.length, (i) {
//       return Schedule.fromJson(maps[i]);
//     });
//   }

//   Future<void> saveReports(List<Map<String, dynamic>> jsonData) async {
//     await openDb();
//     await db!.delete('reports');
//     final batch = db!.batch();
//     for (final json in jsonData) {
//       Map<String, dynamic> map = {};
//       map['_id'] = json["_id"];
//       map['driver_id'] = json["driver_id"];
//       map['driver_name'] = json["driver_name"];
//       map['vehicle_name'] = json["vehicle_name"];
//       map['distance'] = json["distance"];
//       map['price'] = json["price"];
//       map['manager_id'] = json["manager_id"];
//       map['litres'] = json["litres"];
//       batch.insert('reports', map);
//     }
//     await batch.commit();
//   }

//   Future<List<Report>> getReports() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await db!.query('reports');

//     return List.generate(maps.length, (i) {
//       return Report.fromJson(maps[i]);
//     });
//   }

//   Future<void> saveVehicles(List<Map<String, dynamic>> jsonData) async {
//     await openDb();
//     await db!.delete('vehicles');
//     final batch = db!.batch();
//     for (final json in jsonData) {
//       Map<String, dynamic> map = {};
//       map['_id'] = json["_id"];
//       map['manager_id'] = json["manager_id"];
//       map['name'] = json["name"];
//       map['image'] = json["image"];
//       map['license_plate_number'] = json["license_plate_number"];

//       batch.insert('vehicles', map);
//     }
//     await batch.commit();
//   }

//   Future<List<Vehicle>> getVehicles() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await db!.query('vehicles');

//     return List.generate(maps.length, (i) {
//       return Vehicle.fromJson(maps[i]);
//     });
//   }

//   Future<void> saveIssues(List<Map<String, dynamic>> jsonData) async {
//     await openDb();
//     await db!.delete('issues');
//     final batch = db!.batch();
//     for (final json in jsonData) {
//       Map<String, dynamic> map = {};
//       map['_id'] = json["_id"];
//       map['manager_id'] = json["manager_id"];
//       map['driver_id'] = json["driver_id"];
//       map['content'] = json["content"];
//       map['response'] = json["response"];
//       map['status'] = json["status"];
//       map['driver_name'] = json["driver_name"];

//       batch.insert('issues', map);
//     }
//     await batch.commit();
//   }

//   Future<List<Issue>> getIssues() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await db!.query('issues');

//     return List.generate(maps.length, (i) {
//       return Issue.fromJson(maps[i]);
//     });
//   }
// }
