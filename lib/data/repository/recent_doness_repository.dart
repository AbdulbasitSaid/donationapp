import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/recent_donee_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../core/unauthorized_exception.dart';
import '../models/donation_models/recent_donees_model.dart';

class RecentDoneesRepository {
  final RecentDoneesDataSource _recentDoneesDataSource;
  final UserLocalDataSource _userLocalDataSource;
  RecentDoneesRepository(
      this._recentDoneesDataSource, this._userLocalDataSource);

  Future<Either<AppError, RecentDoneesResponseModel>> getRecentDonees() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _recentDoneesDataSource.getRecentDonees(user.token);
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
