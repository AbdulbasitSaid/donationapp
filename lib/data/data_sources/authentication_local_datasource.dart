import 'package:hive/hive.dart';
import 'package:idonatio/data/models/local_user_object.dart';

class AuthenticationLocalDataSource {
  Future<void> saveUserData(LocalUserObject userData) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.put('user_token', userData.token);
    authenticationBox.put('email_verified', userData.isEmailVerified);
    authenticationBox.put('is_onboarded', userData.isBoarded);
  }

  Future<LocalUserObject> getUser() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return LocalUserObject(
      isBoarded: authenticationBox.get('is_onboarded'),
      isEmailVerified: authenticationBox.get('email_verified'),
      token: authenticationBox.get('user_token'),
    );
  }
}
