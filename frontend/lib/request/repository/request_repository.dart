import 'package:pro/request/model/request_model.dart';

import '../data_providers/local_storage/DB_request_data_provider.dart';
import '../data_providers/request_data_provider.dart';
// import '../model/Herd_model.dart';

class RequestRepository {
  final RequestDataProvider dataProvider;
  final RequestDbHelper requestDbHelper;
  RequestRepository(this.dataProvider,this.requestDbHelper);

  Future<Future<Request>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Request> create(Request request) async {
    // return dataProvider.create(request);
    var result = await dataProvider.create(request);
    await requestDbHelper.insertRequest(result);
    return result;
  }

  Future<Future> update(int id, Request request) async {
    // return dataProvider.update(id, request);
    await requestDbHelper.updateRequest(request);
    return dataProvider.update(id, request);
  }
  Future<Future> appove(int id, bool status) async {
    // return dataProvider.update(id, request);
    return dataProvider.approve(id, status);
  }

  Future<List<Request>> fetchAll() async {
    // return await dataProvider.fetchAll();
    try {
      final dataFromLocalDatabase = await requestDbHelper.getRequestLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (Request x in dataFromApi) {
          await requestDbHelper.insertRequest(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  Future<List<Request>> fetchAllforAdmin() async {
    // return await dataProvider.fetchAllforAdmin();
    try {
      final dataFromLocalDatabase = await requestDbHelper.getRequestLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAllforAdmin();
        for (Request x in dataFromApi) {
          await requestDbHelper.insertRequest(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(int id) async {
    // dataProvider.delete(id);
    await requestDbHelper.deleterequest(id.toString());
    dataProvider.delete(id);
  }
}

