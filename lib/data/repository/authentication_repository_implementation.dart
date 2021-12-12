import 'dart:io';

import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/data_sources/authentication_remote_datasource.dart';
import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepository {
  AuthenticationRepository(this._authenticationRemoteDataSourceImpl,
      this._authenticationLocalDataSourceImpl);
  final AuthenticationRemoteDataSource _authenticationRemoteDataSourceImpl;
  final AuthenticationLocalDataSource _authenticationLocalDataSourceImpl;

  Future<Either<AppError, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params) async {
    try {
      final response =
          await _authenticationRemoteDataSourceImpl.loginWithEmail(params);
      final userData = response;
      print(userData.toString());
      await _authenticationLocalDataSourceImpl.saveUserData(LocalUserObject(
          token: userData.data.token,
          isBoarded: userData.data.user.donor.isOnboarded,
          isEmailVerified: userData.data.user.emailVerifiedAt));
      return const Right(true);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, void>> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
