import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/authentication_remote_datasource.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/login_request_params.dart';
import 'package:idonatio/domain/usecases/login_user.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this.loadingCubit,
    this.loginUser,
  ) : super(LoginInitial());
  final LoadingCubit loadingCubit;
  final LoginUser loginUser;
  void initiateLogin(String email, String password) async {
    loadingCubit.show();
    final Either<AppError, bool> eitherResponse = await loginUser(
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
      ),
    );

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return LoginFailed(message);
      },
      (r) {
        return LoginSuccess();
      },
    ));
    loadingCubit.hide();
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return 'ranslationConstants.noNetwork';
      case AppErrorType.api:
      case AppErrorType.database:
        return 'Check that you have entered a correct and registered email address and password.';
      default:
        return 'Check that you have entered a correct and registered email address and password.';
    }
  }
}
