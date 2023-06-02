import 'package:pro/user/model/user_model.dart';

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

  // ignore: non_constant_identifier_names
  Future<Future<String>> get_user() async {
    return dataProvider.get();
  }
}
