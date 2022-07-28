import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:idonatio/data/data_sources/donation_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/donation_models/donation_aggregate_model.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/data/models/donation_summary_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../data/core/unauthorized_exception.dart';
import '../../data/models/donation_models/donation_history_by_donee_id_model.dart';
import '../../data/models/fees_model.dart';

class DonationRepository {
  final DonationDataSources _donationDataSources;
  final UserLocalDataSource _userLocalDataSource;

  DonationRepository(this._donationDataSources, this._userLocalDataSource);

  Future<Either<AppError, DonationHistoryModel>> getDonationHistory({
    int? perPage,
    int? page,
  }) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _donationDataSources.getDonationHistory(
        token: user.token,
        page: page,
      );
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

  Future<Either<AppError, DonationHistoryModel>> searchDonationHistory({
    String searchQuery = '',
    int? page,
  }) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _donationDataSources.searchDonationHistory(
          token: user.token, page: page, searchQuery: searchQuery);
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

  Future<Either<AppError, DonationSummaryModel>> getDonationHistorySummary(
      {required String donorId}) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _donationDataSources.getDonationHistorySummary(
          user.token, donorId);
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

  Future<Either<AppError, DonationHistoryByDoneeIdModel>>
      getDonationHistoryByDoneeId(
          {required String doneeId, required int page}) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _donationDataSources.getDonationHistoryByDoneeId(
        user.token,
        doneeId,
        page: page,
      );
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

  Future<Either<AppError, FeesModel>> getDonationFees() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _donationDataSources.getFees(user.token);
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

  Future<Either<AppError, DonationAggrateModel>>
      getDonationAggregation() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result =
          await _donationDataSources.getDonationsAggregate(user.token);
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
