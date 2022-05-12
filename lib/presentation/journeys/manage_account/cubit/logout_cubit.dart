import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  void logoutUser() async {
    emit(LogoutLoading());
    try {
      emit(LogoutSuccessful());
    } catch (e) {
      log(e.toString());
      emit(const LogoutFailed(errorMessage: 'logout failed'));
    }
  }
}
