import 'package:equatable/equatable.dart';

import '../model/payment_model.dart';




abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentDataLoaded extends PaymentState {
  final Iterable<Payment> payments;

  const PaymentDataLoaded([this.payments = const []]);

  @override
  List<Object> get props => [payments];
}

class PaymentDataLoadingError extends PaymentState {
  final Object error;

  const PaymentDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
