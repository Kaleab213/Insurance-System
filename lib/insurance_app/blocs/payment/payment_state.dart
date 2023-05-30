import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentOperationSuccess extends PaymentState {
  final Iterable<Payment> payments;

  const PaymentOperationSuccess([this.payments = const []]);

  @override
  List<Object> get props => [payments];
}

class PaymentOperationFailure extends PaymentState {
  final Object error;
  const PaymentOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
