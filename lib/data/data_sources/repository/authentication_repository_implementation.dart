import 'dart:io';

import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/repository/authentication_local_datasource.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:idonatio/domain/repository/authentication_repository.dart';

import 'authentication_remote_datasource.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl(this._authenticationRemoteDataSourceImpl,
      this._authenticationLocalDataSourceImpl);
  final AuthenticationRemoteDataSourceImpl _authenticationRemoteDataSourceImpl;
  final AuthenticationLocalDataSourceImpl _authenticationLocalDataSourceImpl;

  @override
  Future<Either<AppError, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, bool>> loginUser(
      Map<String, dynamic> params) async {
    try {
      final response =
          await _authenticationRemoteDataSourceImpl.loginWithEmail(params);
      final userToken = response.userData;
      await _authenticationLocalDataSourceImpl.saveUserData(userToken);
      return const Right(true);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
