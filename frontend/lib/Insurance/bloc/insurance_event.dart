import 'package:equatable/equatable.dart';

import '../model/insurance_model.dart';

abstract class InsuranceEvent extends Equatable {
  const InsuranceEvent();
}

class InsuranceLoad extends InsuranceEvent {
  const InsuranceLoad();

  @override
  List<Object> get props => [];
}
class InsuranceLoadforAdmin extends InsuranceEvent {
  const InsuranceLoadforAdmin();

  @override
  List<Object> get props => [];
}

class InsuranceCreate extends InsuranceEvent {
  final Insurance insurance;

  const InsuranceCreate(this.insurance);

  @override
  List<Object> get props => [insurance];

  @override
  String toString() => 'Insurance Created {Insurance Id: ${insurance.id}}';
}

class InsuranceUpdate extends InsuranceEvent {
  final int id;
  final Insurance insurance;

  const InsuranceUpdate({required this.id, required this.insurance});

  @override
  List<Object> get props => [id, insurance];

  @override
  String toString() => 'Insurance Updated {Insurance Id: ${insurance.id}}';
}

class InsuranceApprove extends InsuranceEvent {
  final int id;
  final bool status;

  const InsuranceApprove({required this.id, required this.status});

  @override
  List<Object> get props => [id, status];

  @override
  String toString() => 'Insurance Updated {Insurance Id: ${id}}';
}

class InsuranceDelete extends InsuranceEvent {
  final int id;

  const InsuranceDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Insurance Deleted {Insurance Id: $id}';

  @override
  bool? get stringify => true;
}



