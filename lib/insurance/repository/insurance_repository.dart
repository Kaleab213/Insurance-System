import 'package:meta/meta.dart';
import 'package:insurancesystem/insurance/models/models.dart';
import 'package:insurancesystem/insurance/data_provider/data_provider.dart';

class InsuranceRepository {
  final InsuranceDataProvider dataProvider;

  InsuranceRepository({required this.dataProvider})
      : assert(dataProvider != null);

  Future<Insurance> createInsurance(Insurance insurance) async {
    return await dataProvider.createInsurance(insurance);
  }

  Future<List<Insurance>> getInsurances() async {
    return await dataProvider.getInsurances();
  }

  Future<void> updateInsurance(Insurance insurance) async {
    await dataProvider.updateInsurance(insurance);
  }

  Future<void> deleteInsurance(Insurance location) async {
    await dataProvider.deleteInsurance(location);
  }
}