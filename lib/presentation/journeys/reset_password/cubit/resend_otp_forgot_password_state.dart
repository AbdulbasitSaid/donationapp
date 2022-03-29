part of 'resend_otp_forgot_password_cubit.dart';

abstract class ResendOtpForgotPasswordState extends Equatable {
  const ResendOtpForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ResendOtpForgotPasswordInitial extends ResendOtpForgotPasswordState {}

class ResendOtpForgotPasswordLoading extends ResendOtpForgotPasswordState {}

class ResendOtpForgotPasswordSuccess extends ResendOtpForgotPasswordState {
  final String message;

  const ResendOtpForgotPasswordSuccess(this.message);
}

class ResendOtpForgotPasswordFailed extends ResendOtpForgotPasswordState {
  final String message;

  const ResendOtpForgotPasswordFailed(this.message);
}
