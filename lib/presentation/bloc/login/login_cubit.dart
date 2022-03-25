import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';

import '../../../data/models/device_info_model.dart';
import '../../reusables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository, this.registerCubit)
      : super(LoginInitial()) {
    registerStream = registerCubit.stream.listen((event) {
      if (event is RegisterLoading) {
        initializeLogin();
      }
    });
  }
  final UserRepository _authenticationRepository;

  final RegisterCubit registerCubit;

  late final StreamSubscription registerStream;
  void initializeLogin() {
    emit(LoginInitial());
  }

  @override
  Future<void> close() {
    registerStream.cancel();
    return super.close();
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
