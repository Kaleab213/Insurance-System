
import '../model/payment_model.dart';
import '../data_providers/payment_data_provider.dart';



class PaymentRepository {
  final PaymentDataProvider dataProvider;
  PaymentRepository(this.dataProvider);

  Future<Future<Payment>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Payment> create(Payment payment) async {
    return dataProvider.create(payment);
  }

  Future<Future> update(int id, Payment payment) async {
    return dataProvider.update(id, payment);
  }

  Future<List<Payment>> fetchAll() async {
    print(dataProvider.fetchAll());
    print("passed2");
    return await dataProvider.fetchAll();
  }
  
  Future<List<Payment>> fetchAllforAdmin() async {
    print(dataProvider.fetchAllforAdmin());
    print("passe");
    return await dataProvider.fetchAllforAdmin();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}
