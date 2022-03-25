import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/register_request_params.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';

import '../../../data/models/device_info_model.dart';
import '../../../di/get_it.dart';
import '../../reusables.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._registerUserRepositoryImpl,
    this._userLocalDataSource,
  ) : super(RegisterInitial());
  final UserRepository _registerUserRepositoryImpl;
  final UserLocalDataSource _userLocalDataSource;
  
  void initiateRegistration(RegisterUserRequestParameter params) async {
    emit(RegisterLoading());
    final DeviceInfoModel deviceInfoModel = Platform.isIOS
        ? await getIosInfo(getItInstance(), getItInstance())
        : await getAndroidInfo(getItInstance(), getItInstance());
    final finalParams = params.copyWith(
      platform: deviceInfoModel.platform!,
      deviceUid: deviceInfoModel.deviceUid!,
      os: deviceInfoModel.os!,
      osVersion: deviceInfoModel.osVersion!,
      model: deviceInfoModel.model!,
      ipAddress: deviceInfoModel.ipAddress ?? 'not found',
      screenResolution: deviceInfoModel.screenResolution!,
    );
    final Either<AppError, dynamic> eitherResponse =
        await _registerUserRepositoryImpl.registerUser(finalParams.toJson());
    String email = params.email;
    await _userLocalDataSource.saveResetPasswordEmail(email);
    emit(
      eitherResponse.fold((l) {
        var message = getErrorMessage(l.appErrorType);
        return RegisterFailed(message);
      }, (r) {
        return RegisterSuccess();
      }),
    );
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return 'No network';
      case AppErrorType.api:
      case AppErrorType.database:
        return 'Opps something went wrong';
      default:
        return 'Email is already taken';
    }
  }
}
