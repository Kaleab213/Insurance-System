import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app_name/bloc/insurance_bloc.dart';
import 'package:your_app_name/bloc/insurance_event.dart';
import 'package:your_app_name/bloc/insurance_state.dart';
import 'package:your_app_name/model/insurance_model.dart';
import 'package:your_app_name/repository/insurance_repository.dart';

class MockInsuranceRepository extends Mock implements InsuranceRepository {}

void main() {
  late InsuranceBloc insuranceBloc;
  late MockInsuranceRepository mockInsuranceRepository;

  setUp(() {
    mockInsuranceRepository = MockInsuranceRepository();
    insuranceBloc = InsuranceBloc(insuranceRepository: mockInsuranceRepository);
  });

  group('InsuranceBloc', () {
    final insurance = Insurance(
      id: 1,
      // Fill in other required properties
    );

    test('initial state is InsuranceLoading', () {
      expect(insuranceBloc.state, equals(InsuranceLoading()));
    });

    test('emits InsuranceDataLoaded after InsuranceLoad event', () async {
      final insurances = [insurance];

      when(mockInsuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceLoad());
    });

    test('emits InsuranceDataLoadedforAdmin after InsuranceLoadforAdmin event', () async {
      final insurances = [insurance];

      when(mockInsuranceRepository.fetchAllforAdmin()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoadingforAdmin(),
        InsuranceDataLoadedforAdmin(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceLoadforAdmin());
    });

    test('emits InsuranceDataLoaded after InsuranceCreate event', () async {
      final insurances = [insurance];

      when(mockInsuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceCreate(insurance));
    });

    test('emits InsuranceDataLoaded after InsuranceUpdate event', () async {
      final insurances = [insurance];

      when(mockInsuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceUpdate(id: 1, insurance: insurance));
    });

    test('emits InsuranceDataLoaded after InsuranceDelete event', () async {
      final insurances = [insurance];

      when(mockInsuranceRepository.fetchAll()).thenAnswer((_) async => insurances);

      final expectedStates = [
        InsuranceLoading(),
        InsuranceDataLoaded(insurances),
      ];

      expectLater(insuranceBloc.stream, emitsInOrder(expectedStates));

      insuranceBloc.add(InsuranceDelete(1));
    });

    tearDown(() {
      insuranceBloc.close();
    });
  });
}
