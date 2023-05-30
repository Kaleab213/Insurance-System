import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repository.dart';
import '../blocs.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository}) : super(PaymentLoading()) {
    on<PaymentLoad>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payments = await paymentRepository.fetchAll();
        emit(PaymentOperationSuccess(payments));
      } catch (error) {
        emit(PaymentOperationFailure(error));
      }
    });

    on<PaymentCreate>((event, emit) async {
      try {
        await paymentRepository.create(event.payment);
        final payments = await paymentRepository.fetchAll();
        emit(PaymentOperationSuccess(payments));
      } catch (error) {
        emit(PaymentOperationFailure(error));
      }
    });
  }
}
