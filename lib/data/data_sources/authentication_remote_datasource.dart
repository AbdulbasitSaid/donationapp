import 'package:http/http.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/user_model.dart';
import 'package:idonatio/domain/entities/onboarding_response.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

class AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSource(this._client);

  Future<UserModel> loginWithEmail(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      'auth/login',
      params: requestBody,
    );
    return UserModel.fromJson(response);
  }

  Future<UserModel> registerUser(Map<String, dynamic> requestBody) async {
    final response = await _client.post('donors/register', params: requestBody);
    return UserModel.fromJson(response);
  }

  Future<dynamic> verifyEmail(Map<String, dynamic> requestBody, token) async {
    final response = await _client.post('auth/verify/email',
        params: requestBody, token: token);
    print(response);
    return response;
  }

  Future<OnboardingResponse> onBoarding(Map<String, dynamic> requestBody,
      {required String? token}) async {
    final response = await _client.patch('donors/onboard',
        params: requestBody, token: token);
    print(response);
    return OnboardingResponse.fromJson(response);
  }

  Future<dynamic> sendOtpToEmail(Map<String, dynamic> params) async {
    final response = await _client.post('auth/password/forgot', params: params);
    return response;
  }

  Future<ResetPasswordOtpSuccessEntity> sendOtp(Map<String, String> map) async {
    final response =
        await _client.patch('auth/password/validate-otp', params: map);
    return ResetPasswordOtpSuccessEntity.fromJson(response);
  }

  Future<dynamic> resendOptCode() async {
    final response = await _client.get('auth/otp/resend');
    return response;
  }

  Future<dynamic> changePassword({required Map<String, dynamic> params}) async {
    final response = await _client.patch('auth/password/reset', params: params);
    return response;
  }
}
