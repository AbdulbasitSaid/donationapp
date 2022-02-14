import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/change_password_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../reusables.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository changePasswordRepository;
  ChangePasswordCubit(this.changePasswordRepository)
      : super(ChangePasswordInitial());
  void changePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordRepository.changePassword({
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': confirmPassword,
    });
    log(result.toString());
    emit(result.fold(
        (l) => ChangePasswordFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) =>
            const ChangePasswordSuccess(successMessage: 'Password updated.')));
  }
}
