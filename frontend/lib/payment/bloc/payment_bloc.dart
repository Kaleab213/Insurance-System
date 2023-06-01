import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pro/Payment/model/payment_model.dart';
// import 'package:pro/payment/bloc/payment_event.dart';
// import 'package:pro/payment/bloc/payment_state.dart';
// import 'package:pro/payment/model/payment_model.dart';
import '../model/payment_model.dart';
import '../repository/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository}) : super(PaymentLoading()) {
    
    on<PaymentLoad>((event, emit) async {
      emit(PaymentLoading());
      try {
        final List<Payment> payments = await paymentRepository.fetchAll();

        emit(
          PaymentDataLoaded(payments),
        );
      } catch (error) {
        print(error);
        emit(PaymentDataLoadingError(error));
      }
    });

    on<PaymentCreate>((event, emit) async {
      try {
        print(event.payment);
        await paymentRepository.create(event.payment);
        final payments = await paymentRepository.fetchAll();
        emit(PaymentDataLoaded(payments));
      } catch (error) {
        print(error);
        emit(PaymentDataLoadingError(error));
      }
    });

    on<PaymentUpdate>((event, emit) async {
      try {
        await paymentRepository.update(event.id, event.payment);
        final payments = await paymentRepository.fetchAll();
        emit(PaymentDataLoaded(payments));
      } catch (error) {
        print(error);
        emit(PaymentDataLoadingError(error));
      }
    });
    
    on<PaymentDelete>((event, emit) async {
      try {
        await paymentRepository.delete(event.id);
        final payments = await paymentRepository.fetchAll();
        emit(PaymentDataLoaded(payments));
      } catch (error) {
        emit(PaymentDataLoadingError(error));
      }
    });
    on<PaymentLoadforAdmin>((event, emit) async {
      emit(PaymentLoadingforAdmin());
      try {
        final List<Payment> payments = await paymentRepository.fetchAllforAdmin();

        emit(











          
          PaymentDataLoadedforAdmin(payments),
        );
      } catch (error) {
        print(error);
        emit(PaymentDataLoadingError(error));
      }
    });
  }
}
