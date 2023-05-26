import '../data_providers/request_data_provider.dart';
import '../models/request.dart';

class RequestRepository {
  final RequestDataProvider dataProvider;
  RequestRepository(this.dataProvider);

  Future<Request> create(Request request) async {
    return dataProvider.create(request);
  }

  Future<Request> update(int id, Request request) async {
    return dataProvider.update(id, request);
  }

  Future<List<Request>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}
