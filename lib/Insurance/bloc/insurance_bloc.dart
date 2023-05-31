import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/insurance_model.dart';
import '../repository/insurance_repository.dart';
import 'insurance_event.dart';
import 'insurance_state.dart';

class InsuranceBloc extends Bloc<InsuranceEvent, InsuranceState> {
  final InsuranceRepository insuranceRepository;

  InsuranceBloc({required this.insuranceRepository}) : super(InsuranceLoading()) {
    on<InsuranceLoad>((event, emit) async {
      emit(InsuranceLoading());
      try {
        final List<Insurance> insurances = await insuranceRepository.fetchAll() as List<Insurance>;

        emit(
          InsuranceDataLoaded(insurances),
        );
      } catch (error) {
        print(error);
        emit(InsuranceDataLoadingError(error));
      }
    });

    on<InsuranceCreate>((event, emit) async {
      try {
        print(event.insurance);
        await insuranceRepository.create(event.insurance);
        final insurances = await insuranceRepository.fetchAll();
        emit(InsuranceDataLoaded(insurances));
      } catch (error) {
        print(error);
        emit(InsuranceDataLoadingError(error));
      }
    });

    on<InsuranceUpdate>((event, emit) async {
      try {
        await insuranceRepository.update(event.id, event.insurance);
        final insurances = await insuranceRepository.fetchAll();
        emit(InsuranceDataLoaded(insurances));
      } catch (error) {
        print(error);
        emit(InsuranceDataLoadingError(error));
      }
    });

    on<InsuranceDelete>((event, emit) async {
      try {
        await insuranceRepository.delete(event.id);
        final insurances = await insuranceRepository.fetchAll();
        emit(InsuranceDataLoaded(insurances));
      } catch (error) {
        emit(InsuranceDataLoadingError(error));
      }
    });
  }
}
