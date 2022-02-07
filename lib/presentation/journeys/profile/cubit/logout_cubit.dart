import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/user_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._authenticationRepository) : super(LogoutInitial());
  final UserRepository _authenticationRepository;
  void logoutUser() async {
    emit(LogoutLoading());
    try {
      _authenticationRepository.logoutUser();
      emit(LogoutSuccessful());
    } catch (e) {
      log(e.toString());
      emit(const LogoutFailed(errorMessage: 'logout failed'));
    }
  }
}
