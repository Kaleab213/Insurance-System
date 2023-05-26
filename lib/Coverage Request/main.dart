import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'coverage_request/bloc_observer.dart';
import 'coverage_request/blocs/blocs.dart';
import 'coverage_request/data_providers/request_data_provider.dart';
import 'coverage_request/repository/request_repository.dart';
import 'coverage_request/screens/request_route.dart';

void main() {
  final RequestRepository requestRepository =
      RequestRepository(RequestDataProvider());

  BlocOverrides.runZoned(
    () => runApp(
      RequestApp(requestRepository: requestRepository),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class RequestApp extends StatelessWidget {
  final RequestRepository requestRepository;

  const RequestApp({Key? key, required this.requestRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: requestRepository,
      child: BlocProvider(
        create: (context) => RequestBloc(requestRepository: requestRepository)
          ..add(const RequestLoad()),
        child: MaterialApp(
          title: 'Request App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: RequestAppRoute.generateRoute,
        ),
      ),
    );
  }
}
