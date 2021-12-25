part of 'verification_cubit.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final String successMessage;

  const VerificationSuccess({required this.successMessage});
}

class VerificationLoading extends VerificationState {}

class VerificationFailure extends VerificationState {
  final String errorMessage;

  const VerificationFailure({required this.errorMessage});
}
