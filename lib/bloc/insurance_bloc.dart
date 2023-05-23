import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurancesystem/insurance/bloc/bloc.dart';
import 'package:insurancesystem/insurance/insurance.dart';

class InsuranceBloc extends Bloc<InsuranceEvent, InsuranceState> {
  final InsuranceRepository insuranceRepository;

  InsuranceBloc({required this.insuranceRepository})
      : assert(insuranceRepository != null),
        super(InsuranceLoading());

  @override
  Stream<InsuranceState> mapEventToState(InsuranceEvent event) async* {
    if (event is InsuranceLoad) {
      yield InsuranceLoading();
      try {
        final insurances = await insuranceRepository.getInsurances();
        yield InsurancesLoadSuccess(insurances);
      } catch (_) {
        yield InsuranceOperationFailure();
      }
    }

    if (event is InsuranceCreate) {
      try {
        await insuranceRepository.createInsurance(event.insurance);
        final insurances = await insuranceRepository.getInsurances();
        yield InsurancesLoadSuccess(insurances);
      } catch (_) {
        yield InsuranceOperationFailure();
      }
    }

    if (event is InsuranceUpdate) {
      try {
        await insuranceRepository.updateInsurance(event.insurance);
        final insurances = await insuranceRepository.getInsurances();
        yield InsurancesLoadSuccess(insurances);
      } catch (_) {
        yield InsuranceOperationFailure();
      }
    }

    if (event is InsuranceDelete) {
      try {
        await insuranceRepository.deleteInsurance(event.insurance.id);
        final insurances = await insuranceRepository.getInsurances();
        yield InsurancesLoadSuccess(insurances);
      } catch (_) {
        yield InsuranceOperationFailure();
      }
    }
  }
}