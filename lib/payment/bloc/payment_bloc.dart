import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/Payment/model/payment_model.dart';
import 'package:pro/payment/bloc/payment_event.dart';
import 'package:pro/payment/bloc/payment_state.dart';
import '../repository/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository}) : super(PaymentLoading()) {
    on<PaymentLoad>(
      (event, emit) async {
        emit(PaymentLoading());
        try {
          final payments = await paymentRepository.fetchAll();
          emit(PaymentDataLoaded(payments));
        } catch (error) {
          emit(PaymentDataLoadingError(error));
        }
      },
    );

    on<PaymentCreate>(
      (event, emit) async {
        try {
          await paymentRepository.create(event.payment);
          final payments = await paymentRepository.fetchAll();
          emit(PaymentDataLoaded(payments));
        } catch (error) {
          emit(PaymentDataLoadingError(error));
        }
      },
    );

    on<PaymentUpdate>(
      (event, emit) async {
        try {
          await paymentRepository.update(event.id, event.payment);
          final payments = await paymentRepository.fetchAll();
          emit(PaymentDataLoaded(payments));
        } catch (error) {
          emit(PaymentDataLoadingError(error));
        }
      },
    );

    on<PaymentDelete>(
      (event, emit) async {
        try {
          await paymentRepository.delete(event.id);
          final payments = await paymentRepository.fetchAll();
          emit(PaymentDataLoaded(payments));
        } catch (error) {
          emit(PaymentDataLoadingError(error));
        }
      },
    );
  }
}
