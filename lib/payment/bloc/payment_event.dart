import 'package:equatable/equatable.dart';

import '../model/payment_model.dart';


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
  String toString() => 'Payment Created {Payment Id: $payment.id}';
}

class PaymentUpdate extends PaymentEvent {
  final String id;
  final Payment payment;

  const PaymentUpdate(this.id, this.payment);

  @override
  List<Object> get props => [id, payment];

  @override
  String toString() => 'Payment Updated {Payment Id: $payment.id}';
}

class PaymentDelete extends PaymentEvent {
  final String id;

  const PaymentDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Payment Deleted {Payment Id: $id}';

  @override
  bool? get stringify => true;
}
