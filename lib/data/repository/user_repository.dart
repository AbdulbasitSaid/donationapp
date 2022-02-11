import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/data_sources/user_remote_datasource.dart';
import 'package:idonatio/data/models/payment_success_model.dart';
import 'package:idonatio/data/models/user_models/user_response_model.dart';

import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/onboarding_response.dart';
import 'package:idonatio/presentation/journeys/reset_password/enitities/reset_password_otp_success_entity.dart';

class UserRepository {
  UserRepository(this._userRemoteDataSource, this._userLocalDataSource);
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params) async {
    try {
      final response = await _userRemoteDataSource.loginWithEmail(params);
      final data = response.data;
      final user = response.data.user;
      final donor = response.data.user.donor;
      await _userLocalDataSource
          .saveUserData(data.copyWith(user: user.copyWith(donor: donor)));
      // await _userLocalDataSource.saveUserData(LocalUserObject(
      //     token: userData.data.token,
      //     isBoarded: userData.data.user.donor.isOnboarded,
      //     stripeCustomerId: userData.data.stripeCustomerId,
      //     userEmail: userData.data.user.email,
      //     isEmailVerified:
      //         userData.data.user.emailVerifiedAt?.toIso8601String(),
      //     lastName: userData.data.user.donor.lastName,
      //     firstName: userData.data.user.donor.firstName));
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
      final response = await _userRemoteDataSource.registerUser(params);
      final userData = response.data;
      final user = response.data.user;
      final donor = response.data.user.donor;
      await _userLocalDataSource
          .saveUserData(userData.copyWith(user: user.copyWith(donor: donor)));

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
      final user = await _userLocalDataSource.getUser();
      final response =
          await _userRemoteDataSource.verifyEmail(params, user.token);
      await _userLocalDataSource.updateUserData(user.copyWith(
          user: user.user.copyWith(emailVerifiedAt: DateTime.now())));
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
      final user = await UserLocalDataSource().getUser();
      final response =
          await _userRemoteDataSource.onBoarding(params, token: user.token);
      await _userLocalDataSource.updateUserData(user.copyWith(
          user: user.user.copyWith(
              donor: user.user.donor.copyWith(
        isOnboarded: true,
        firstName: response.data.firstName,
        lastName: response.data.lastName,
      ))));

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
      final responce =
          await _userRemoteDataSource.sendOtpToEmail({'email': email});
      return Right(StatusMessageEntity.fromMap(responce));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  Future<void> logoutUser() async {
    await _userLocalDataSource.deleteUserData();
  }

  Future<Either<AppError, ResetPasswordOtpSuccessEntity>> sendOtpForgotPassword(
      String otp, String email) async {
    try {
      final localUser = await _userLocalDataSource.getUser();
      final response =
          await _userRemoteDataSource.sendOtp({"email": email, "otp": otp});
      await _userLocalDataSource.updateUserData(localUser.copyWith(
        user: localUser.user.copyWith(
          email: response.data.email,
        ),
      ));
      // await _userLocalDataSource.saveResetPasswordAndToken(
      //     email: response.data.email,
      //     passwordResetToken: response.data.passwordResetToken);
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
