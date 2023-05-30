import 'package:equatable/equatable.dart';
import '../../insurance.dart';

abstract class InsuranceEvent extends Equatable {
  const InsuranceEvent();
}

class InsuranceLoad extends InsuranceEvent {
  const InsuranceLoad();

  @override
  List<Object> get props => [];
}

class InsuranceCreate extends InsuranceEvent {
  final Insurance insurance;

  const InsuranceCreate(this.insurance);

  @override
  List<Object> get props => [insurance];

  @override
  String toString() => 'Insurance Created {insurance: $insurance}';
}

class InsuranceUpdate extends InsuranceEvent {
  final Insurance insurance;

  const InsuranceUpdate(this.insurance);

  @override
  List<Object> get props => [insurance];

  @override
  String toString() => 'Insurance Updated {insurance: $insurance}';
}

class InsuranceDelete extends InsuranceEvent {
  final Insurance insurance;

  const InsuranceDelete(this.insurance);

  @override
  List<Object> get props => [insurance];

  @override
  String toString() => 'Insurance Deleted {insurance: $insurance}';
}
