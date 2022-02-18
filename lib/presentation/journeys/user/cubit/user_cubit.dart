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
  final LoginCubit loginCubit;
  late StreamSubscription _loginStreamSubscription;

  UserCubit(this.localUserDataSource, this.loginCubit)
      : super(AuthenticationInitial()) {
    setUserState(localUserDataSource, AuthStatus.appStarted);
  }
  void setUserState(
      UserLocalDataSource localDataSource, AuthStatus authStatus) async {
    final user = await localUserDataSource.getUser();
    log(user.toString());
    switch (authStatus) {
      case AuthStatus.appStarted:
        _checkUserToken(user);
        break;
      case AuthStatus.unauthenticated:
        emit(UnSaved());
        break;
      case AuthStatus.authenticated:
        _checkEmailVerification(user);
        break;
      default:
        break;
    }
  }

  void _checkUserToken(UserData user) {
    if (user.token.isNotEmpty) {
      emit(UnAuthenticated());
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
      emit(Authenticated());
    } else {
      log(user.toString());
      emit(NotBoarded(localUserObject: user));
    }
  }

  @override
  Future<void> close() {
    _loginStreamSubscription.cancel();
    return super.close();
  }
}
