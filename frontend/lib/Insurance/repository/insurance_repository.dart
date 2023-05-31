import '../data_providers/API/API_insurance_data_provider.dart';
import '../model/insurance_model.dart';

class InsuranceRepository {
  final InsuranceDataProvider dataProvider;
  InsuranceRepository(this.dataProvider);

  Future<Future<Insurance>> fetchOne(int id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Insurance> create(Insurance insurance) async {
    return dataProvider.create(insurance);
  }

  Future<Future> update(int id, Insurance insurance) async {
    return dataProvider.update(id, insurance);
  }

  Future<List<Insurance>> fetchAll() async {
    print(dataProvider.fetchAll());
    print("passed2");
    return await dataProvider.fetchAll();
  }
  
  Future<List<Insurance>> fetchAllforAdmin() async {
    print(dataProvider.fetchAllforAdmin());
    print("passe");
    return await dataProvider.fetchAllforAdmin();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}
