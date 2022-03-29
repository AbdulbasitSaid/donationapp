part of 'send_otp_forgot_password_cubit.dart';

abstract class SendOtpForgotPasswordState extends Equatable {
  const SendOtpForgotPasswordState();

  @override
  List<Object> get props => [];
}

class SendOtpForgotPasswordInitial extends SendOtpForgotPasswordState {}

class SendOtpForgotPasswordLoading extends SendOtpForgotPasswordState {}

class SendOtpForgotPasswordSuccess extends SendOtpForgotPasswordState {
  final String message;

  const SendOtpForgotPasswordSuccess(this.message);
}

class SendOtpForgotPasswordFailed extends SendOtpForgotPasswordState {
  final String message;

  const SendOtpForgotPasswordFailed(this.message);
}
