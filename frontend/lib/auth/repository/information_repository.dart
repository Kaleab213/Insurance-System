import 'package:pro/user/model/User_model.dart';

// import '../../user/model/User_model.dart';
import '../data_providers/auth_data_provider.dart';
import '../model/auth.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  AuthRepository(this.dataProvider);

  Future<User> login(Auth auth) async {
    // var x = await dataProvider.post_login(auth);
    
    return await dataProvider.post_login(auth);
  }

  Future<User> signup(User user) async {
    return await dataProvider.post_signup(user);
  }
  
  Future<User> update_account(User user) async {
    return await dataProvider.update_account(user);
  }

 Future<bool> delete_account() async {
    return dataProvider.delete_account();
  }

  Future<Future<String>> logout() async {
    return dataProvider.logout();
  }
  // ignore: non_constant_identifier_names
  Future<String> get_user() async {
    return dataProvider.get();
  }
}