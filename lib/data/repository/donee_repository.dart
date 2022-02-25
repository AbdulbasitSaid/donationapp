import 'package:dartz/dartz.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/donee_remote_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../models/donation_models/donee_response_model.dart';

class DoneeRepository {
  final DoneeRemoteDataSource _doneeRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  DoneeRepository(
    this._doneeRemoteDataSource,
    this._userLocalDataSource,
  );

  Future<Either<AppError, DoneeResponseModel>> getDoneeById(
    String doneeCode,
  ) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _doneeRemoteDataSource.getDoneeByCode(user.token, doneeCode);
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on NetworkError {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, SuccessModel>> deleteSavedDonee(
    String doneeId,
  ) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _doneeRemoteDataSource.deleteSavedDonee(user.token, doneeId);
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on NetworkError {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, SuccessModel>> saveDonee(
    Map<String, dynamic> doneeId,
  ) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _doneeRemoteDataSource.saveDonee(user.token, doneeId);
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on InternalServerError {
      return const Left(AppError(appErrorType: AppErrorType.serveError));
    } on NetworkError {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }
}
