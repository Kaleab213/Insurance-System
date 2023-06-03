
import '../data_providers/local_storage/DB_payment_data_provider.dart';
import '../model/payment_model.dart';
import '../data_providers/payment_data_provider.dart';



class PaymentRepository {
  final PaymentDataProvider dataProvider;
  final PaymentDbHelper paymentDbHelper;
  PaymentRepository(this.dataProvider,this.paymentDbHelper);

  Future<Future<Payment>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Payment> create(Payment payment) async {
    // return dataProvider.create(payment);
    var result = await dataProvider.create(payment);
    await paymentDbHelper.insertPayment(result);
    return result;
  }

  Future<Future> update(int id, Payment payment) async {
    // return dataProvider.update(id, payment);
    await paymentDbHelper.updatePayment(payment);
    return dataProvider.update(id, payment);
  }

  Future<List<Payment>> fetchAll() async {

    // return await dataProvider.fetchAll();
    try {
      final dataFromLocalDatabase = await paymentDbHelper.getPaymentLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (Payment x in dataFromApi) {
          await paymentDbHelper.insertPayment(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  Future<List<Payment>> fetchAllforAdmin() async {
    // return await dataProvider.fetchAllforAdmin();
    try {
      final dataFromLocalDatabase = await paymentDbHelper.getPaymentLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAllforAdmin();
        for (Payment x in dataFromApi) {
          await paymentDbHelper.insertPayment(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(int id) async {
    // dataProvider.delete(id);
    await paymentDbHelper.deletepayment(id.toString());
    dataProvider.delete(id);
  }
}
