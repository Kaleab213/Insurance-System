import '../data_providers/user_data_provider.dart';
import '../model/user_model.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  UserRepository(this.dataProvider);

  Future<User> create(User user) async {
    return dataProvider.create(user);
  }

  Future<User> update(String id, User user) async {
    return dataProvider.update(id, user);
  }

  Future<List<User>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    dataProvider.delete(id);
  }
}
