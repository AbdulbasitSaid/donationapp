import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';

import '../../../domain/repository/user_repository.dart';
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
    // final DeviceInfoModel deviceInfoModel = Platform.isIOS
    //     ? await getIosInfo(getItInstance(), getItInstance())
    //     : await getAndroidInfo(getItInstance(), getItInstance());
    final Either<AppError, bool> eitherResponse =
        await _authenticationRepository.loginUser(
            LoginRequestParams(
              email: email,
              password: password,
              platform: 'mobile',
              deviceUid: '272892-08287-398903903',
              os: 'android',
              osVersion: '10',
              model: 'samsung s21',
              ipAddress: '',
              screenResolution: '198.0.2.3',
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
