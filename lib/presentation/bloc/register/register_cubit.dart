import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/register_request_params.dart';

import '../../../data/models/user_models/user_response_model.dart';
import '../../../domain/repository/user_repository.dart';

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
    final Either<AppError, UserResponseModel> eitherResponse =
        await _registerUserRepositoryImpl.registerUser(finalParams.toJson());
    String email = params.email;
    await _userLocalDataSource.saveResetPasswordEmail(email);

    emit(
      eitherResponse.fold((l) {
        var message = _getErrorMessage(l.appErrorType);
        return RegisterFailed(message);
      }, (r) {
        _userLocalDataSource.saveUserData(UserData(
          token: r.data.token,
          tokenType: r.data.tokenType,
          expiresIn: r.data.expiresIn,
          isDeviceSaved: r.data.isDeviceSaved,
          user: r.data.user,
          stripeCustomerId: r.data.stripeCustomerId,
        ));
        return RegisterSuccess();
      }),
    );
  }

  void reset() async {
    emit(RegisterInitial());
  }
}

_getErrorMessage(AppErrorType appErrorType) {
  switch (appErrorType) {
    case AppErrorType.unProcessableEntity:
      return 'This email address has already been taken.';
    case AppErrorType.badRequest:
      return 'The request was unacceptable, often due the parameter provided by the client.';
    case AppErrorType.network:
      return 'Please check your internet';
    case AppErrorType.unauthorized:
      return 'No bearer token provided or an invalid bearer token was provided.';
    case AppErrorType.forbidden:
      return 'Authentication failed. This may occur when a wrong email or password is provided during login.';
    case AppErrorType.notFound:
      return 'The requested resource doesn\'t exist.';
    case AppErrorType.serveError:
      return 'Server error. Hopefully this will occur in rear cases.';
    case AppErrorType.serverNotAvailble:
      return 'Server not available at the moment please try again!! later';
    case AppErrorType.unExpected:
      return 'Unexpected error.';
    default:
      return 'Opps something went wrong';
  }
}
