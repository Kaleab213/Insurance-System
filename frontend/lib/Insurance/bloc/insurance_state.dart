import 'package:equatable/equatable.dart';

import '../model/insurance_model.dart';

abstract class InsuranceState extends Equatable {
  const InsuranceState();

  @override
  List<Object> get props => [];
}

class InsuranceLoading extends InsuranceState {}

class InsuranceDataLoaded extends InsuranceState {
  final List<Insurance> insurances;
  final String userRole = "COSTOMER";

  const InsuranceDataLoaded([this.insurances = const []]);

  @override
  List<Object> get props => [insurances];
}

class InsuranceLoadingforAdmin extends InsuranceState {}

class InsuranceDataLoadedforAdmin extends InsuranceState {
  final List<Insurance> myinsurance;
  final String userRole = "ADMIN";
  const InsuranceDataLoadedforAdmin([this.myinsurance = const []]);

  @override
  List<Object> get props => [myinsurance];
}

class InsuranceDataLoadingError extends InsuranceState {
  final Object error;

  const InsuranceDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
