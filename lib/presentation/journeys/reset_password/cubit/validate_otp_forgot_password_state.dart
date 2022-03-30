part of 'validate_otp_forgot_password_cubit.dart';

abstract class ValidateOtpForgotPasswordState extends Equatable {
  const ValidateOtpForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ValidateOtpForgotPasswordInitial extends ValidateOtpForgotPasswordState {}

class ValidateOtpForgotPasswordLoading extends ValidateOtpForgotPasswordState {}

class ValidateOtpForgotPasswordSuccess extends ValidateOtpForgotPasswordState {
  final ResetPasswordOtpSuccessEntity response;
  const ValidateOtpForgotPasswordSuccess(this.response);
}

class ValidateOtpForgotPasswordFailed extends ValidateOtpForgotPasswordState {
  final String message;

  const ValidateOtpForgotPasswordFailed(this.message);
}
