import 'package:pro/request/model/request_model.dart';

import '../data_providers/request_data_provider.dart';
// import '../model/Herd_model.dart';

class RequestRepository {
  final RequestDataProvider dataProvider;
  RequestRepository(this.dataProvider);

  Future<Future<Request>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Request> create(Request request) async {
    return dataProvider.create(request);
  }

  Future<Future> update(int id, Request request) async {
    return dataProvider.update(id, request);
  }

  Future<List<Request>> fetchAll() async {
    print(dataProvider.fetchAll());
    print("passed2");
    return await dataProvider.fetchAll();
  }
  
  Future<List<Request>> fetchAllforAdmin() async {
    print(dataProvider.fetchAllforAdmin());
    print("passe");
    return await dataProvider.fetchAllforAdmin();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}

