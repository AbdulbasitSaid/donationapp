import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/data_sources/user_remote_datasource.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/data/models/user_models/get_authenticated_user_model.dart';
import 'package:idonatio/data/models/user_models/user_response_model.dart';

import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/onboarding_response.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

import '../models/user_models/password_validate_otp_model.dart';

class UserRepository {
  UserRepository(this._userRemoteDataSource, this._userLocalDataSource);
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  Future<Either<AppError, bool>> loginUser(
      Map<String, dynamic> params, bool isRememberMe) async {
    try {
      final response = await _userRemoteDataSource.loginWithEmail(params);
      final data = response.data;
      final user = response.data.user;
      final donor = response.data.user.donor;

      await _userLocalDataSource
          .saveUserData(data.copyWith(user: user.copyWith(donor: donor)));
      isRememberMe
          ? await _userLocalDataSource.rememberMeEmail(user.email)
          : await _userLocalDataSource.deleteResetRememberMeEmail();
      return const Right(true);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      log('e');
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, GetAuthenticatedUserModel>>
      getAuthenticatedUser() async {
    try {
      final userData = await _userLocalDataSource.getUser();
      final result =
          await _userRemoteDataSource.getAuthenticatedUser(userData.token);
      await _userLocalDataSource
          .saveUserData(userData.copyWith(user: result.data.user));

      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, UserResponseModel>> registerUser(
      Map<String, dynamic> params) async {
    try {
      final response = await _userRemoteDataSource.registerUser(params);
      final userData = response.data;
      await _userLocalDataSource.saveUserData(userData);

      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, dynamic>> verifyEmail(
      Map<String, dynamic> params) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final response =
          await _userRemoteDataSource.verifyEmail(params, user.token);
      await _userLocalDataSource.updateUserData(user.copyWith(
          user: user.user.copyWith(emailVerifiedAt: DateTime.now())));
      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, dynamic>> refereshUserToken(String token) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final response =
          await _userRemoteDataSource.getRefereshToken(token: user.token);
      await _userLocalDataSource
          .updateUserData(user.copyWith(token: response.data.token));
      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, OnboardingResponse>> boardUser(
      Map<String, dynamic> params) async {
    try {
      final user = await UserLocalDataSource().getUser();
      final response =
          await _userRemoteDataSource.onBoarding(params, token: user.token);

      await _userLocalDataSource.updateUserData(
        user.copyWith(
          user: user.user.copyWith(
            donor: user.user.donor.copyWith(
              isOnboarded: response.data.isOnboarded,
              giftAidEnabled: response.data.giftAidEnabled,
              paymentMethod: response.data.paymentMethod,
              phoneReceiveSecurityAlert:
                  response.data.phoneReceiveSecurityAlert,
              sendMarketingMail: response.data.sendMarketingMail,
              firstName: response.data.firstName,
              lastName: response.data.lastName,
              donateAnonymously: response.data.donateAnonymously,
            ),
          ),
        ),
      );

      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, PasswordValidateResponseModel>>
      passwordValidateOtp() async {
    try {
      return Right(PasswordValidateResponseModel());
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  /// Password Reset
  Future<Either<AppError, StatusMessageEntity>> sendEmailForgotPassword(
    String email,
  ) async {
    try {
      final responce =
          await _userRemoteDataSource.sendOtpToEmail({'email': email});
      return Right(StatusMessageEntity.fromMap(responce));
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  // validate the Email
  Future<Either<AppError, ResetPasswordOtpSuccessEntity>>
      valiteOtpForgotPassword(String otp, String email) async {
    try {
      final response = await _userRemoteDataSource
          .validateOtpForgotPassword({"email": email, "otp": otp});
      log(response.toString());
      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  // reset the password
  Future<Either<AppError, SuccessModel>> resetPassword(
      {required String password,
      required String email,
      required String passwordToken}) async {
    try {
      final result = await _userRemoteDataSource.resetPassword(params: {
        'email': email,
        'password': password,
        'password_reset_token': passwordToken,
      });
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on ServerNotAvailableError {
      return const Left(AppError(appErrorType: AppErrorType.serverNotAvailble));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  ///
  Future<Either<AppError, SuccessModel>> logoutUser() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _userRemoteDataSource.logout(token: user.token);
      await _userLocalDataSource.deleteUserData();
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, SuccessModel>> closeAccount() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _userRemoteDataSource.closeAccount(user.token);
      await _userLocalDataSource.deleteUserData();
      await _userLocalDataSource.deleteResetRememberMeEmail();
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, SuccessModel>> resendOtpCode() async {
    try {
      final userEmail = await _userLocalDataSource.getPasswordResetEmail();
      final result =
          await _userRemoteDataSource.resendOptCode({'email': userEmail});
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Forbidden {
      return const Left(AppError(appErrorType: AppErrorType.forbidden));
    } on NotFound {
      return const Left(AppError(appErrorType: AppErrorType.notFound));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }
}

class StatusMessageEntity extends Equatable {
  final String status;
  final String message;

  const StatusMessageEntity({required this.status, required this.message});
  @override
  List<Object?> get props => [status, message];

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory StatusMessageEntity.fromMap(Map<String, dynamic> map) {
    return StatusMessageEntity(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusMessageEntity.fromJson(String source) =>
      StatusMessageEntity.fromMap(json.decode(source));
}
