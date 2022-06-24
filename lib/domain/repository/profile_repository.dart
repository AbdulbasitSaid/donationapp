import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/profile_remote_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';

import '../../data/core/unauthorized_exception.dart';
import '../../data/models/user_models/profile_response_model.dart';
import '../../domain/entities/app_error.dart';

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
      //
      await userLocalDataSource.updateUserData(user.copyWith(
        user: result.data.user.copyWith(donor: result.data.user.donor),
      ));
      return Right(result);
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
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
