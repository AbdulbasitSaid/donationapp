import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/saved_donees_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../core/unauthorized_exception.dart';
import '../models/donation_models/saved_donees_model.dart';

class SavedDoneesRepository {
  final SavedDoneeDataSource _savedDoneeDataSource;
  final UserLocalDataSource _localDataSource;

  SavedDoneesRepository(this._savedDoneeDataSource, this._localDataSource);

  Future<Either<AppError, SavedDoneesResponseModel>> getSavedDonee(
      {String? param = ''}) async {
    try {
      final user = await _localDataSource.getUser();
      final result =
          await _savedDoneeDataSource.getSavedDonees(user.token, param);
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }
}
