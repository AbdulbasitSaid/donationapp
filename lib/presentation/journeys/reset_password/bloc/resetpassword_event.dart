part of 'resetpassword_bloc.dart';

abstract class ResetpasswordEvent extends Equatable {
  const ResetpasswordEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmail extends ResetpasswordEvent {
  final String email;

  const ValidateEmail({required this.email});
}

class SendOtp extends ResetpasswordEvent {
  final String otp;
  final String email;
  const SendOtp({required this.otp, required this.email});
}

class ResendOtpCode extends ResetpasswordEvent {}

class ChangeToNewPassword extends ResetpasswordEvent {
  final String password;

  const ChangeToNewPassword({
    required this.password,
  });
}
