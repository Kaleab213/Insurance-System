import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  Future testDb() async {
    db = await openDb();
    await db!.execute(
        'INSERT INTO insurances VALUES (1111, 2222, 2, "220x213", "AddisAbaba", "Apartment",  3)');
    await db!.execute(
        'INSERT INTO requests VALUES (3333, 60560, 124, 5, "220x213", "AddisAbaba", "092145357", "092145357","092145357", "Its Impossible to describe", "1/2/3", "2/3/4", "pending", "Kaleab Tibebu", 2222, 1111, 1)');
    await db!.execute(
        'INSERT INTO users VALUES (1111, "0901711106", "kaleabtibebu400@gmail.com", "123we2")');
    await db!.execute('INSERT INTO payments VALUES (1111, 2222, 3333, 9000)');
    await db!.execute('INSERT INTO notifications VALUES (1111, 2222, 96000)');
    List<Map<String, Object?>> insurances =
        await db!.rawQuery('select * from insurances');
    List<Map<String, Object?>> requests =
        await db!.rawQuery('select * from requests');
    List<Map<String, Object?>> users =
        await db!.rawQuery('select * from users');
    List<Map<String, Object?>> payments =
        await db!.rawQuery('select * from payments');
    List<Map<String, Object?>> notifications =
        await db!.rawQuery('select * from notifications');
    print(insurances[0].toString());
    print(requests[0].toString());
    print(users[0].toString());
    print(payments[0].toString());
    print(notifications[0].toString());
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'insurance.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE insurances(insuranceId INTEGER PRIMARY KEY, userId INTEGER,' +
                'numberOfRooms INTEGER, size TEXT, location TEXT, propertyType TEXT, ' +
                'level INTEGER, FOREIGN KEY(userId) REFERENCES users(userId))');
        database.execute('CREATE TABLE requests(coverageId INTEGER PRIMARY KEY, ' +
            'paymentAmount INTEGER,' +
            'houseNumber INTEGER,houseAge INTEGER, size TEXT, location TEXT,' +
            'witness1Number TEXT,witness2Number TEXT,witness3Number TEXT,' +
            'description TEXT, createdAt TEXT, updatedAt TEXT,status TEXT,' +
            'userName TEXT, insuranceId INTEGER, userId INTEGER, level INTEGER,' +
            'FOREIGN KEY(userId) REFERENCES users(userId))');
        database.execute(
            'CREATE TABLE users(userId INTEGER PRIMARY KEY, phoneNumber Text,' +
                'email Text, password TEXT)');
        database.execute(
            'CREATE TABLE payments(transactionId INTEGER PRIMARY KEY, userId INTEGER,' +
                'insuranceId INTEGER, paymentAmount INTEGER)');
        database.execute(
            'CREATE TABLE notifications(notificationId INTEGER PRIMARY KEY, ' +
                'userId INTEGER, paymentAmount INTEGER,' +
                'FOREIGN KEY(userId) REFERENCES users(userId))');
      }, version: version);
    }
    return db!;
  }
}

// // import 'package:path/path.dart';
// // import 'package:sqflite/sqflite.dart';
// // import '../models/list_items.dart';
// // import '../models/shopping_list.dart';

// // class DbHelper {
// //   final int version = 1;
// //   Database? db;

//   // static final DbHelper _dbHelper = DbHelper._internal();
//   // DbHelper._internal();
//   // factory DbHelper() {
//   //   return _dbHelper;
//   // }

//   Future testDb() async {
//     db = await openDb();
//     await db.execute(
//         'INSERT INTO insurances VALUES (1111, 2222, 2, "220x213", "AddisAbaba", "Apartment",  3)');
//     await db.execute(
//         'INSERT INTO requests VALUES (3333, 60560, 124, 5, "220x213", "AddisAbaba", "092145357", "092145357","092145357", "Its Impossible to describe", "1/2/3", "2/3/4", "pending", "Kaleab Tibebu", 2222, 1111, 1)');
//     await db.execute(
//         'INSERT INTO users VALUES (1111, "0901711106", "kaleabtibebu400@gmail.com", "123we2")');
//     await db.execute('INSERT INTO payments VALUES (1111, 2222, 3333, 9000)');
//     await db.execute('INSERT INTO notifications VALUES (1111, 2222, 96000)');
//     List insurances = await db.rawQuery('select * from insurances');
//     List requests = await db.rawQuery('select * from requests');
//     List users = await db.rawQuery('select * from users');
//     List payments = await db.rawQuery('select * from payments');
//     List notifications = await db.rawQuery('select * from notifications');
//     print(insurances[0].toString());
//     print(requests[0].toString());
//     print(users[0].toString());
//     print(payments[0].toString());
//     print(notifications[0].toString());
//   }

//   Future<Database> openDb() async {
//     if (db == null) {
//       db = await openDatabase(join(await getDatabasesPath(), 'insurance.db'),
//           onCreate: (database, version) {
//         database.execute(
//             'CREATE TABLE insurances(insuranceId INTEGER PRIMARY KEY, userId INTEGER,' +
//                 'numberOfRooms INTEGER, size TEXT, location TEXT, propertyType TEXT, ' +
//                 'level INTEGER, FOREIGN KEY(userId) REFERENCES insurances(insuranceId))');
//         database.execute('CREATE TABLE requests(coverageId INTEGER PRIMARY KEY, ' +
//             'paymentAmount INTEGER,' +
//             'houseNumber INTEGER,houseAge INTEGER, size TEXT, location TEXT,' +
//             'witness1Number TEXT,witness2Number TEXT,witness3Number TEXT,' +
//             'description TEXT, createdAt TEXT, updatedAt TEXT,status TEXT,' +
//             'userName TEXT, insuranceId INTEGER, userId INTEGER, level INTEGER,' +
//             'FOREIGN KEY(userId) REFERENCES requests(coverageId))');
//         database.execute(
//             'CREATE TABLE users(userId INTEGER PRIMARY KEY, phoneNumber Text,' +
//                 'email Text, password TEXT');
//         database.execute(
//             'CREATE TABLE payments(transactionId INTEGER PRIMARY KEY, userId INTEGER,' +
//                 'insuranceId INTEGER, paymentAmount INTEGER');
//         database.execute(
//             'CREATE TABLE notifications(notificationId INTEGER PRIMARY KEY, ' +
//                 'userId INTEGER, paymentAmount INTEGER,' +
//                 'FOREIGN KEY(userId) REFERENCES insurances(notificationId))');
//       }, version: version);
//     }
//     return db;
//   }

//   // Future<int> insertList(ShoppingList list) async {
//   //   int id = await this.db.insert(
//   //         'lists',
//   //         list.toMap(),
//   //         conflictAlgorithm: ConflictAlgorithm.replace,
//   //       );
//   //   return id;
//   // }

//   // Future<int> insertItem(ListItem item) async {
//   //   int id = await db.insert(
//   //     'items',
//   //     item.toMap(),
//   //     conflictAlgorithm: ConflictAlgorithm.replace,
//   //   );
//   //   return id;
//   // }

//   // Future<List<ShoppingList>> getLists() async {
//   //   final List<Map<String, dynamic>> maps = await db.query('lists');
//   //   return List.generate(maps.length, (i) {
//   //     return ShoppingList(
//   //       maps[i]['id'],
//   //       maps[i]['name'],
//   //       maps[i]['priority'],
//   //     );
//   //   });
//   // }

//   // Future<List<ListItem>> getItems(int idList) async {
//   //   final List<Map<String, dynamic>> maps =
//   //       await db.query('items', where: 'idList = ?', whereArgs: [idList]);
//   //   return List.generate(maps.length, (i) {
//   //     return ListItem(
//   //       maps[i]['id'],
//   //       maps[i]['idList'],
//   //       maps[i]['name'],
//   //       maps[i]['quantity'],
//   //       maps[i]['note'],
//   //     );
//   //   });
//   // }

// // Future<int> deleteList(ShoppingList list) async {
// //     int result = await db.delete("items", where: "idList = ?", whereArgs: [list.id]);
// //     result = await db.delete("lists", where: "id = ?", whereArgs: [list.id]);
// //     return result;
// //   }
// }
