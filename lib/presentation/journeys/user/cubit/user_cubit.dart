import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserLocalDataSource localUserDataSource;

  UserCubit(this.localUserDataSource) : super(AuthenticationInitial()) {
    setUserState(localUserDataSource, AuthStatus.appStarted);
  }
  void setUserState(
      UserLocalDataSource localDataSource, AuthStatus authStatus) async {
    final user = await localUserDataSource.getUser();
    final rememberEmail = await localUserDataSource.getRememberMeEmail();
    log(user.toString());
    switch (authStatus) {
      case AuthStatus.appStarted:
        _checkUserToken(user, rememberEmail ?? '');
        break;
      case AuthStatus.unauthenticated:
        emit(UnAuthenticated(rememberMeEmail: rememberEmail ?? ''));
        break;
      case AuthStatus.authenticated:
        _checkEmailVerification(user);
        break;
      default:
        break;
    }
  }

  void _checkUserToken(UserData user, String? rememberMeEmail) {
    if (user.token.isNotEmpty) {
      emit(UnAuthenticated(rememberMeEmail: rememberMeEmail));
    } else {
      emit(UnSaved());
    }
  }

  void _checkEmailVerification(UserData user) {
    if (user.user.emailVerifiedAt != null) {
      _checkOnboardingStatus(user);
    } else {
      emit(EmailNotVerified());
    }
  }

  void _checkOnboardingStatus(UserData user) {
    if (user.user.donor.isOnboarded) {
      emit(Authenticated(user));
    } else {
      log(user.toString());
      emit(NotBoarded(localUserObject: user));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
