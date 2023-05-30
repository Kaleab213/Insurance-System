import '../data_providers/payment_data_provider.dart';
import '../models/payment.dart';

class PaymentRepository {
  final PaymentDataProvider dataProvider;
  PaymentRepository(this.dataProvider);

  Future<Payment> create(Payment payment) async {
    return dataProvider.create(payment);
  }

  Future<List<Payment>> fetchAll() async {
    return dataProvider.fetchAll();
  }
}
