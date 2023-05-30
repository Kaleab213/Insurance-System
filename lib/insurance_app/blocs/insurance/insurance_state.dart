import 'package:equatable/equatable.dart';
import '../../insurance.dart';

class InsuranceState extends Equatable {
  const InsuranceState();

  @override
  List<Object> get props => [];
}

class InsuranceLoading extends InsuranceState {}

class InsurancesLoadSuccess extends InsuranceState {
  final List<Insurance> insurances;

  InsurancesLoadSuccess([this.insurances = const []]);

  @override
  List<Object> get props => [insurances];
}

class InsuranceOperationFailure extends InsuranceState {}
