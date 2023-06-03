import '../data_providers/API/API_insurance_data_provider.dart';
import '../data_providers/local_storage/DB_insurance_data_provider.dart';
import '../model/insurance_model.dart';

class InsuranceRepository {
  final InsuranceDataProvider dataProvider;
  final InsuranceDbHelper insuranceDbHelper;
  InsuranceRepository(this.dataProvider, this.insuranceDbHelper);

  Future<Future<Insurance>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Insurance> create(Insurance insurance) async {
    // return dataProvider.create(insurance);
    var result = await dataProvider.create(insurance);
    await insuranceDbHelper.insertInsurance(result);
    return result;
  }

  Future<Future> update(int id, Insurance insurance) async {
    // return dataProvider.update(id, insurance);
    await insuranceDbHelper.updateInsurance(insurance);
    return dataProvider.update(id, insurance);
  }
  
  Future<Future> approve(int id, bool status) async {
    // return dataProvider.update(id, insurance);
    // await insuranceDbHelper.updatInsurance(status);
    return dataProvider.approve_insurance(id, status);
  }

  Future<List<Insurance>> fetchAll() async {
    // print(dataProvider.fetchAll());
    // print("passed2");
    // return await dataProvider.fetchAll();
    try {
      final dataFromLocalDatabase = await insuranceDbHelper.getInsuranceLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAll();
        for (Insurance x in dataFromApi) {
          await insuranceDbHelper.insertInsurance(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Insurance>> fetchAllforAdmin() async {
    try {
      final dataFromLocalDatabase = await insuranceDbHelper.getInsuranceLists();
      if (dataFromLocalDatabase.isNotEmpty) {
        return dataFromLocalDatabase;
      } else {
        final dataFromApi = await dataProvider.fetchAllforAdmin();
        for (Insurance x in dataFromApi) {
          await insuranceDbHelper.insertInsurance(x);
        }

        return dataFromApi;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(int id) async {
    // dataProvider.delete(id);
    await insuranceDbHelper.deleteinsurance(id.toString());
    dataProvider.delete(id);
  }
}