import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class PaymentLoad extends PaymentEvent {
  const PaymentLoad();

  @override
  List<Object> get props => [];
}

class PaymentCreate extends PaymentEvent {
  final Payment payment;

  const PaymentCreate(this.payment);

  @override
  List<Object> get props => [payment];

  @override
  String toString() => 'Payment Created {payment Id: ${payment.transactionId}}';
}
