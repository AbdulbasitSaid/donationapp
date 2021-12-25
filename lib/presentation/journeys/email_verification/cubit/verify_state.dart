part of 'verify_cubit.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final String successMessage;

  const VerificationSuccess(this.successMessage);
}

class VerificationLoading extends VerificationState {}

class VerificationFailue extends VerificationState {
  final String errorMessage;
  const VerificationFailue({
    required this.errorMessage,
  });
}

enum VerificationStatus { initial, loading, success, failure }

extension VerificationStatusX on VerificationStatus {
  bool get isInitial => this == VerificationStatus.initial;
  bool get isLoading => this == VerificationStatus.loading;
  bool get isSuccess => this == VerificationStatus.success;
  bool get isFailure => this == VerificationStatus.failure;
}
