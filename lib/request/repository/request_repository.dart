import 'package:pro/request/model/request_model.dart';

import '../data_providers/request_data_provider.dart';
// import '../model/Herd_model.dart';

class RequestRepository {
  final RequestDataProvider dataProvider;
  RequestRepository(this.dataProvider);

  Future<Future<Request>> fetchOne(String id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Request> create(Request request) async {
    return dataProvider.create(request);
  }

  Future<Request> update(String id, Request request) async {
    return dataProvider.update(id, request);
  }

  Future<List<Request>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    dataProvider.delete(id);
  }
}
