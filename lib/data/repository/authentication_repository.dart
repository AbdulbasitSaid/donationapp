import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/data_sources/authentication_remote_datasource.dart';
import 'package:idonatio/data/models/auth_models/user_response_model.dart';
import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/onboarding_response.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

class AuthenticationRepository {
  AuthenticationRepository(this._authenticationRemoteDataSource,
      this._authenticationLocalDataSource);
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  Future<Either<AppError, void>> logout() {
    throw UnimplementedError();
  }

  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params) async {
    try {
      final response =
          await _authenticationRemoteDataSource.loginWithEmail(params);
      final userData = response;
      await _authenticationLocalDataSource.saveUserData(LocalUserObject(
          token: userData.data.token,
          isBoarded: userData.data.user.donor.isOnboarded,
          isEmailVerified:
              userData.data.user.emailVerifiedAt!.toIso8601String(),
          lastName: userData.data.user.donor.lastName,
          firstName: userData.data.user.donor.firstName));
      return const Right(true);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<Either<AppError, UserResponseModel>> registerUser(
      Map<String, dynamic> params) async {
    try {
      UserResponseModel response =
          await _authenticationRemoteDataSource.registerUser(params);
      final userData = response;
      await _authenticationLocalDataSource.saveUserData(LocalUserObject(
          token: userData.data.token,
          isBoarded: userData.data.user.donor.isOnboarded,
          isEmailVerified:
              userData.data.user.emailVerifiedAt?.toIso8601String(),
          lastName: userData.data.user.donor.lastName,
          firstName: userData.data.user.donor.firstName));
      return Right(response);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<Either<AppError, dynamic>> verifyEmail(
      Map<String, dynamic> params) async {
    try {
      final user = await AuthenticationLocalDataSource().getUser();
      final response =
          await _authenticationRemoteDataSource.verifyEmail(params, user.token);
      await _authenticationLocalDataSource.setEmailVarified();
      return Right(response);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<Either<AppError, OnboardingResponse>> boardUser(
      Map<String, dynamic> params) async {
    try {
      final user = await AuthenticationLocalDataSource().getUser();
      final response = await _authenticationRemoteDataSource.onBoarding(params,
          token: user.token);
      await _authenticationLocalDataSource.saveUserData(LocalUserObject(
          token: user.token,
          isBoarded: response.data.isOnboarded,
          firstName: response.data.firstName,
          lastName: response.data.lastName,
          isEmailVerified: user.isEmailVerified));
      return Right(response);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<Either<AppError, StatusMessageEntity>> sendEmailForgotPassword(
      String email) async {
    try {
      final responce = await _authenticationRemoteDataSource
          .sendOtpToEmail({'email': email});
      return Right(StatusMessageEntity.fromMap(responce));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<Either<AppError, void>> logoutUser() {
    throw UnimplementedError();
  }

  Future<Either<AppError, ResetPasswordOtpSuccessEntity>> sendOtpForgotPassword(
      String otp, String email) async {
    try {
      final response = await _authenticationRemoteDataSource
          .sendOtp({"email": email, "otp": otp});
      await _authenticationLocalDataSource.saveResetPasswordAndToken(
          email: response.data.email,
          passwordResetToken: response.data.passwordResetToken);
      return Right(response);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, String>> resendOtpCode() async {
    try {
      return const Right('OTP resent successfully.');
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, String>> changePassword(
      {required String newPassword}) async {
    try {
      return const Right("Password reset successfully");
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
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
