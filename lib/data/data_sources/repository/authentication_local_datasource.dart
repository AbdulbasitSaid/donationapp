import 'package:hive/hive.dart';
import 'package:idonatio/data/models/user_model.dart';

abstract class AuthenticationLocalDatasource {
  Future<void> saveUserData(UserData userData);
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDatasource {
  @override
  Future<void> saveUserData(UserData userData) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.put('user_token', userData.token);
    authenticationBox.put('email_verified', userData.user.emailVerifiedAt);
    authenticationBox.put('is_active', userData.user.isActive);
  }
}
