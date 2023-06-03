import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../model/payment_model.dart';





class   PaymentDbHelper {
  final int version = 1;
  late Database db;

  static final PaymentDbHelper _dbHelper = PaymentDbHelper._internal();
  PaymentDbHelper._internal();
  factory PaymentDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'Payment.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Payment(insuranceId INT, bill Text, id INT, amount DOUBLE,createdAt TIME, updatedAt TIME, status BOOL)');
        
    }, version: version);

    return db;
  }

  Future<int> insertPayment(Payment payment) async {
    print(payment.toString());
    return await db.insert(
      'Payment',
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatePayment(Payment payment) async {

    await db.update(
      'Payment',
      payment.toMap(),
      where: "id = ?",
      whereArgs: [payment.id],
    );
  }

  Future<List<Payment>> getPaymentLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Payment');
    return List.generate(
      maps.length,
      (i) {
        return Payment(
          ammount: maps[i]["amount"],
          id: maps[i]["id"],
          bill: maps[i]["bill"],
          updatedAt: maps[i]["updatedAt"],
          status: maps[i]["status"] 
        );
      },
    ).toList();
  }

  Future<int> deletepayment(String id) async {
    int result = await db.delete("Insurance", where: "id = ?", whereArgs: [id]);
    // print(result);
    return result;
  }
}