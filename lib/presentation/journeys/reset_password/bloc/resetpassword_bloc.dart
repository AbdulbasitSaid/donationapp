import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  final UserRepository _authenticationRepository;
  final UserLocalDataSource _userLocalDataSource;
  ResetpasswordBloc(this._authenticationRepository, this._userLocalDataSource)
      : super(ResetpasswordInitial()) {
    on<ValidateEmail>(_onValidateEmail);
    on<SendOtp>(_onSendOtp);
    on<ResendOtpCode>(_onResendOtpCode);
    on<ChangeToNewPassword>(_onChangeToNewPassword);
  }
  FutureOr<void> _onChangeToNewPassword(
      ChangeToNewPassword event, Emitter<ResetpasswordState> emit) async {
    emit(ResetpasswordLoadding());
    final response = await _authenticationRepository.changePassword(
        newPassword: event.password);
    emit(response.fold(
        (l) => ResetpasswordFailed(
            errorTitle: "Failed to Reset password",
            errorMessage: getPassWordResetErrorMessage(l.appErrorType)),
        (r) => const ResetpasswordSuccess(
            successMessage: 'Password reset successful')));
  }

  Future<void> _onValidateEmail(
      ValidateEmail event, Emitter<ResetpasswordState> emit) async {
    try {
      emit(ResetpasswordLoadding());
      await _authenticationRepository.sendEmailForgotPassword(event.email);
      await _userLocalDataSource.saveResetPasswordEmail(event.email);
      emit(const ResetpasswordSuccess(
          successMessage:
              'If the email you entered is correct, an OTP has been sent to the email'));
    } on UnprocessableEntity {
      emit(const ResetpasswordFailed(
          errorTitle: 'Validation error',
          errorMessage: 'The email must be a valid email address.'));
    } on Exception {
      emit(const ResetpasswordFailed(
          errorTitle: 'Unexpected', errorMessage: 'Opp Something went wrong!'));
    }
  }

  FutureOr<void> _onSendOtp(
      SendOtp event, Emitter<ResetpasswordState> emit) async {
    emit(ResetpasswordLoadding());
    final response = await _authenticationRepository.sendOtpForgotPassword(
        event.otp, event.email);
    emit(response.fold(
        (l) => ResetpasswordFailed(
            errorTitle: 'Error', errorMessage: getErrorMessage(l.appErrorType)),
        (r) => ResetpasswordSuccess(successMessage: r.message)));
  }

  FutureOr<void> _onResendOtpCode(
      ResendOtpCode event, Emitter<ResetpasswordState> emit) async {
    try {
      emit(ResetpasswordLoadding());
      await _authenticationRepository.resendOtpCode();
      emit(const ResetpasswordSuccess(
          successMessage: 'OTP resent successfully.'));
    } on Exception {
      emit(
        const ResetpasswordFailed(
            errorTitle: 'Error', errorMessage: 'Opps something went wrong'),
      );
    }
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;

      case AppErrorType.unProcessableEntity:
        return 'Please check your token';
      case AppErrorType.database:
        return 'The email must be a valid email address.';
      default:
        return 'Failed to Validate token';
    }
  }

  String getPassWordResetErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.unExpected:
        return 'Opps something went wrong';
      case AppErrorType.badRequest:
        return 'Email is not registered or Virified';
      case AppErrorType.unProcessableEntity:
        return "The password must be at least 8 characters.";
      default:
        return 'Opps something went wrong';
    }
  }
}
