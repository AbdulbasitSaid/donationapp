import 'package:hive/hive.dart';
import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

class AuthenticationLocalDataSource {
  Future<void> saveUserData(LocalUserObject userData) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.put('user_token', userData.token);
    authenticationBox.put('email_verified', userData.isEmailVerified);
    authenticationBox.put('is_onboarded', userData.isBoarded);
    authenticationBox.put('first_name', userData.firstName);
    authenticationBox.put('last_name', userData.lastName);
  }

  Future<LocalUserObject> getUser() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return LocalUserObject(
      isBoarded: authenticationBox.get('is_onboarded'),
      isEmailVerified: authenticationBox.get('email_verified'),
      token: authenticationBox.get('user_token'),
      firstName: authenticationBox.get('first_name'),
      lastName: authenticationBox.get('last_name'),
    );
  }

  Future<void> deleteUserData() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete(
      'user_token',
    );
    authenticationBox.delete(
      'email_verified',
    );
    authenticationBox.delete(
      'is_onboarded',
    );
    authenticationBox.delete(
      'first_name',
    );
    authenticationBox.delete(
      'last_name',
    );
  }

  Future<void> setEmailVarified() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.put('email_verified', 'this user is temp varified');
  }

  Future<void> saveResetPasswordAndToken(
      {required String? email, required String? passwordResetToken}) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.put('email', email);
    authenticationBox.put('password_reset_token', passwordResetToken);
  }

  Future<ResetPasswordOtpSuccessEntityDataData>
      getSaveResetPasswordAndToken() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return ResetPasswordOtpSuccessEntityDataData(
        email: authenticationBox.get('email'),
        passwordResetToken: authenticationBox.get('password_reset_token'));
  }
}
