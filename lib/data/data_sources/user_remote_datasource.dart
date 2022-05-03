import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/data/models/user_models/user_response_model.dart';
import 'package:idonatio/domain/entities/onboarding_response.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

import '../models/user_models/get_authenticated_user_model.dart';
import '../models/user_models/referesh_token_model.dart';

class UserRemoteDataSource {
  final ApiClient _client;

  UserRemoteDataSource(this._client);

  Future<UserResponseModel> loginWithEmail(
      Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      'auth/login',
      params: requestBody,
    );
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> registerUser(
      Map<String, dynamic> requestBody) async {
    final response = await _client.post('donors/register', params: requestBody);
    return UserResponseModel.fromJson(response);
  }

  Future<GetAuthenticatedUserModel> getAuthenticatedUser(String token) async {
    final response = await _client.get('auth/user', token: token);
    return GetAuthenticatedUserModel.fromJson(response);
  }

  Future<dynamic> verifyEmail(Map<String, dynamic> requestBody, token) async {
    final response = await _client.post('auth/verify/email',
        params: requestBody, token: token);
    return response;
  }

  Future<OnboardingResponse> onBoarding(Map<String, dynamic> requestBody,
      {required String? token}) async {
    final response = await _client.patch('donors/onboard',
        params: requestBody, token: token);
    return OnboardingResponse.fromJson(response);
  }

  Future<dynamic> sendOtpToEmail(Map<String, dynamic> params) async {
    final response = await _client.post('auth/password/forgot', params: params);
    return response;
  }

  /// reset password
  /// send otp forgot password
  Future<ResetPasswordOtpSuccessEntity> sendOtpForgotPassword(
      Map<String, String> map) async {
    final response = await _client.post('auth/password/forgot', params: map);
    return ResetPasswordOtpSuccessEntity.fromJson(response);
  }

  /// auth/password/validate-otp
  Future<ResetPasswordOtpSuccessEntity> validateOtpForgotPassword(
      Map<String, String> map) async {
    final response =
        await _client.patch('auth/password/validate-otp', params: map);
    return ResetPasswordOtpSuccessEntity.fromJson(response);
  }

  //
  /// reset password
  Future<SuccessModel> resetPassword(
      {required Map<String, dynamic> params}) async {
    final response = await _client.patch('auth/password/reset', params: params);
    log(response);
    return SuccessModel.fromJson(response);
  }

  Future<RefereshTokenModel> getRefereshToken({required String token}) async {
    final response = await _client.get('auth/refresh', token: token);
    log(response.toString());
    return RefereshTokenModel.fromJson(response);
  }

  /// end reset password

  Future<SuccessModel> resendOptCode(Map<String, String> map) async {
    final response = await _client.post('auth/password/forgot', params: map);

    return SuccessModel.fromJson(response);
  }

  Future<SuccessModel> logout({required String token}) async {
    final response = await _client.post('auth/logout', token: token);
    return SuccessModel.fromJson(response);
  }

  Future<SuccessModel> closeAccount(String token) async {
    final responce = await _client.patch('auth/close-account', token: token);
    log(responce.toString());
    return SuccessModel.fromJson(responce);
  }
}
