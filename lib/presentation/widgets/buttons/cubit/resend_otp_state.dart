part of 'resend_otp_cubit.dart';

abstract class ResendOtpState extends Equatable {
  const ResendOtpState();

  @override
  List<Object> get props => [];
}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {
  final SuccessModel successModel;

  const ResendOtpSuccess(this.successModel);
}

class ResendOtpFailed extends ResendOtpState {
  final String errorMessage;

  const ResendOtpFailed(this.errorMessage);
}
