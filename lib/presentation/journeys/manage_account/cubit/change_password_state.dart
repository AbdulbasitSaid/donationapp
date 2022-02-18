part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String successMessage;

  const ChangePasswordSuccess({required this.successMessage});
}

class ChangePasswordFailed extends ChangePasswordState {
  final String errorMessage;
  final AppErrorType appErrorType;
  const ChangePasswordFailed(
      {required this.errorMessage, required this.appErrorType});
}
