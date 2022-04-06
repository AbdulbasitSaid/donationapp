import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/profile_remote_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';

import '../../domain/entities/app_error.dart';
import '../core/unauthorized_exception.dart';
import '../models/user_models/profile_response_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  ProfileRepository(this.profileRemoteDataSource, this.userLocalDataSource);

  // updateUser(Map<String, String> map) {}

  Future<Either<AppError, UpdateProfileResponseModel>> updateUser(
      Map<String, dynamic> params) async {
    try {
      final user = await userLocalDataSource.getUser();
      final result =
          await profileRemoteDataSource.updateProfile(user.token, params);
      final newDonorDetial = result.data.user.donor;
      await userLocalDataSource.updateUserData(user.copyWith(
        user: user.user
            .copyWith(donor: newDonorDetial, email: result.data.user.email),
      ));
      return Right(result);
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
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
