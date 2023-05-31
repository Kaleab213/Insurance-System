
import '../model/payment_model.dart';
import '../data_providers/payment_data_provider.dart';



class PaymentRepository {
  final PaymentDataProvider dataProvider;
  PaymentRepository(this.dataProvider);

  Future<Future<Payment>> fetchOne(String id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Payment> create(Payment payment) async {
    return dataProvider.create(payment);
  }

  Future<Payment> update(String id, Payment payment) async {
    return dataProvider.update(id, payment);
  }

  Future<List<Payment>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    dataProvider.delete(id);
  }
}
