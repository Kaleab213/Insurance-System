import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'insurance_app/bloc_observer.dart';
import 'insurance_app/insurance.dart';
import 'package:http/http.dart' as http;
import 'insurance_app/screens/insurance/Insurance_route.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final InsuranceRepository insuranceRepository = InsuranceRepository(
    dataProvider: InsuranceDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    InsuranceApp(insuranceRepository: insuranceRepository),
  );
}

class InsuranceApp extends StatelessWidget {
  final InsuranceRepository insuranceRepository;

  InsuranceApp({required this.insuranceRepository})
      : assert(insuranceRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.insuranceRepository,
      child: BlocProvider(
        create: (context) =>
            InsuranceBloc(insuranceRepository: this.insuranceRepository)
              ..add(InsuranceLoad()),
        child: MaterialApp(
          title: 'Insurance App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: InsuranceAppRoute.generateRoute,
        ),
      ),
    );
  }
}
