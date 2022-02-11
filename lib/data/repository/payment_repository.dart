import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/payment_success_model.dart';
import 'package:idonatio/data/models/user_models/payment_method_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/set_up_intent_entity.dart';

class PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepository(this._apiClient);
  Future<Either<AppError, SetUpIntentModel>> createSetupIntent() async {
    try {
      final user = await UserLocalDataSource().getUser();
      final response =
          await _apiClient.post('donors/payment-methods', token: user?.token);
      return Right(SetUpIntentModel.fromMap(response));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on Exception {
      // log(response);
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, PaymentMethodsModel>> getPaymentMethods(
      UserLocalDataSource userLocalDataSource) async {
    try {
      final user = await userLocalDataSource.getUser();
      final response =
          await _apiClient.get('donors/payment-methods', token: user?.token);
      return Right(PaymentMethodsModel.fromMap(response));
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }

  Future<Either<AppError, PaymentSuccessModel>> makeDonation(
      UserLocalDataSource userLocalDataSource,
      Map<dynamic, dynamic> params) async {
    try {
      final user = await userLocalDataSource.getUser();
      final response = await _apiClient.post('donors/donations',
          token: user?.token, params: params);
      log(response.toString());
      return Right(PaymentSuccessModel.fromMap(response));
    } on UnprocessableEntity {
      return const Left(
          AppError(appErrorType: AppErrorType.unProcessableEntity));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.unExpected));
    }
  }
}

