import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../data/core/unauthorized_exception.dart';
import '../../data/data_sources/change_password_datasource.dart';
import '../../data/models/base_success_model.dart';

class ChangePasswordRepository {
  final ChangePasswordDataSource _changePasswordDataSource;
  final UserLocalDataSource _userLocalDataSource;
  ChangePasswordRepository(
      this._changePasswordDataSource, this._userLocalDataSource);

  Future<Either<AppError, SuccessModel>> changePassword(
      Map<String, dynamic> params) async {
    try {
      var user = await _userLocalDataSource.getUser();
      var result =
          await _changePasswordDataSource.changePassword(params, user.token);
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
