import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/country_remote_datasource.dart';
import 'package:idonatio/data/models/countries_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

class CountriesRepository {
  final CountryRemoteDataSource _countryRemoteDataSource;

  CountriesRepository(this._countryRemoteDataSource);

  Future<Either<AppError, CountriesModel>> getCountry() async {
    try {
      final result = await _countryRemoteDataSource.getCountries();
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
