import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';
import 'package:idonatio/domain/entities/no_param.dart';
import 'package:idonatio/domain/usecases/login_user.dart';
import 'package:idonatio/domain/usecases/logout_user.dart';

import 'cubit/loading_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final LoadingCubit loadingCubit;

  LoginCubit({
    required this.loginUser,
    required this.logoutUser,
    required this.loadingCubit,
  }) : super(LoginInitial());

  void initiateLogin(String email, String password) async {
    loadingCubit.show();
    final Either<AppError, bool> eitherResponse = await loginUser(
      LoginRequestParams(
        userName: email,
        password: password,
        deviceUid: '',
        email: '',
        ipAddress: '',
        model: '',
        os: '',
        osVersion: '',
        platform: '',
        screenResolution: '',
      ),
    );

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return LoginError(message);
      },
      (r) => LoginSuccess(),
    ));
    loadingCubit.hide();
  }

  void initiateGuestLogin() async {
    emit(LoginSuccess());
  }

  void logout() async {
    await logoutUser(NoParams());
    emit(LogoutSuccess());
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
