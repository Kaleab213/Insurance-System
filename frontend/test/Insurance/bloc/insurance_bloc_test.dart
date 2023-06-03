import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../bloc/insurance_bloc.dart';
import '../event/insurance_event.dart';
import '../model/insurance_model.dart';
import '../repository/insurance_repository.dart';
import '../state/insurance_state.dart';

class MockInsuranceRepository extends Mock implements InsuranceRepository {}

void main() {
  late InsuranceBloc insuranceBloc;
  late AdminInsuranceBloc adminInsuranceBloc;
  late InsuranceRepository insuranceRepository;

  setUp(() {
    insuranceRepository = MockInsuranceRepository();
    insuranceBloc = InsuranceBloc(insuranceRepository: insuranceRepository);
    adminInsuranceBloc =
        AdminInsuranceBloc(insuranceRepository: insuranceRepository);
  });

  group('InsuranceBloc', () {
    final insurance = Insurance(id: '1', name: 'Insurance 1');

    test('initial state is InsuranceLoading', () {
      expect(insuranceBloc.state, equals(InsuranceLoading()));
    });

    test('emits InsuranceDataLoaded after successful InsuranceLoad event', () async {
      final List<Insurance> insurances = [insurance];

      when(insuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceLoad());
    });

    test('emits InsuranceDataLoadingError after unsuccessful InsuranceLoad event', () async {
      final error = 'Error loading insurances';

      when(insuranceRepository.fetchAll()).thenThrow(error);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoadingError(error),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceLoad());
    });

    test('emits InsuranceDataLoaded after successful InsuranceCreate event', () async {
      final List<Insurance> insurances = [insurance];
      final event = InsuranceCreate(insurance: insurance);

      when(insuranceRepository.create(insurance)).thenAnswer((_) async {});
      when(insuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(event);
    });

    // Add more test cases for other events and scenarios
  });

  group('AdminInsuranceBloc', () {
    final insurance = Insurance(id: '1', name: 'Insurance 1');

    test('initial state is InsuranceLoading', () {
      expect(adminInsuranceBloc.state, equals(InsuranceLoading()));
    });

    test('emits InsuranceDataLoadedforAdmin after successful InsuranceLoadforAdmin event', () async {
      final List<Insurance> insurances = [insurance];

      when(insuranceRepository.fetchAllforAdmin()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoadingforAdmin(),
        InsuranceDataLoadedforAdmin(insurances),
      ];

      expectLater(adminInsuranceBloc.stream, emitsInOrder(expectedStates));

      adminInsuranceBloc.add(InsuranceLoadforAdmin());
    });

    test('emits InsuranceDataLoadingError after unsuccessful InsuranceLoadforAdmin event', () async {
      final error = 'Error loading insurances for admin';

      when(insuranceRepository.fetchAllforAdmin()).thenThrow(error);

      final expectedStates = [
        InsuranceLoadingforAdmin(),
        InsuranceDataLoadingError(error),
      ];

      expectLater(adminInsuranceBloc.stream, emitsInOrder(expectedStates));

      adminInsuranceBloc.add(InsuranceLoadforAdmin());
    });

    // Add more test cases for other events and scenarios
  });
}
