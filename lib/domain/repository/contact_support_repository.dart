import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/contact_support_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../data/core/unauthorized_exception.dart';

class ContactSupportRepository {
  final ContactSupportDatasource _contactSupportDatasource;
  final UserLocalDataSource _userLocalDataSource;
  ContactSupportRepository(
      this._contactSupportDatasource, this._userLocalDataSource);
  Future<Either<AppError, SuccessModel>> contactSupport(
      Map<String, dynamic> params) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _contactSupportDatasource.contactSupport(params, user.token);
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
