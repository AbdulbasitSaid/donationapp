
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/register_request_params.dart';

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
    // final DeviceInfoModel deviceInfoModel = Platform.isIOS
    //     ? await getIosInfo(getItInstance(), getItInstance())
    //     : await getAndroidInfo(getItInstance(), getItInstance());
    final finalParams = params.copyWith(
      platform: 'mobile',
      deviceUid: '272892-08287-398903903',
      os: 'ios',
      osVersion: '10',
      model: 'samsung s21',
      ipAddress: '198.0.2.3"',
      screenResolution: '1080p',
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


}
