import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../../data/models/device_info_model.dart';
import '../../reusables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitial());
  final UserRepository _authenticationRepository;
  void initializeLogin() {
    emit(LoginInitial());
  }

  void initiateLogin(String email, String password, bool isRememberMe) async {
    emit(LoginLoading());
    final DeviceInfoModel deviceInfoModel = Platform.isIOS
        ? await getIosInfo(getItInstance(), getItInstance())
        : await getAndroidInfo(getItInstance(), getItInstance());
    final Either<AppError, bool> eitherResponse =
        await _authenticationRepository.loginUser(
            LoginRequestParams(
              email: email,
              password: password,
              platform: deviceInfoModel.platform!,
              deviceUid: deviceInfoModel.deviceUid!,
              os: deviceInfoModel.os!,
              osVersion: deviceInfoModel.osVersion!,
              model: deviceInfoModel.model!,
              ipAddress: deviceInfoModel.ipAddress ?? 'not found',
              screenResolution: deviceInfoModel.screenResolution!,
            ).toJson(),
            isRememberMe);

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        return LoginFailed(message);
      },
      (r) {
        return LoginSuccess();
      },
    ));
  }
}
