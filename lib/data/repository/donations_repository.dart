import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/donation_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../core/unauthorized_exception.dart';

class DonationRepository {
  final DonationDataSources _donationDataSources;
  final UserLocalDataSource _userLocalDataSource;

  DonationRepository(this._donationDataSources, this._userLocalDataSource);

  Future<Either<AppError, DonationHistoryModel>> getDonationHistory(
      {String? params = ''}) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _donationDataSources.getDonationHistory(user.token, params);
      return Right(result);
    } on BadRequest {
      return const Left(AppError(appErrorType: AppErrorType.badRequest));
    } on NetworkError {
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
