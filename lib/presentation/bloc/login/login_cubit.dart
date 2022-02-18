import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';

import '../../reusables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitial());
  final UserRepository _authenticationRepository;
  void initializeLogin() {
    emit(LoginInitial());
  }

  void initiateLogin(String email, String password) async {
    emit(LoginLoading());
    final Either<AppError, bool> eitherResponse =
        await _authenticationRepository.loginUser(
      LoginRequestParams(
        email: email,
        password: password,
        platform: 'mobile',
        deviceUid: '272892-08287-398903903',
        os: 'ios',
        osVersion: '190',
        model: 'samsung s281',
        ipAddress: '198.0.2.3',
        screenResolution: '1080p',
      ).toJson(),
    );

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
