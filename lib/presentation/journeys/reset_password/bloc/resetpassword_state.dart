part of 'resetpassword_bloc.dart';

abstract class ResetpasswordState extends Equatable {
  const ResetpasswordState();

  @override
  List<Object> get props => [];
}

class ResetpasswordInitial extends ResetpasswordState {}

class ResetpasswordLoadding extends ResetpasswordState {}

class ResetpasswordSuccess extends ResetpasswordState {
  final String successMessage;

  const ResetpasswordSuccess({required this.successMessage});
}

class ResetpasswordFailed extends ResetpasswordState {
  final String errorTitle, errorMessage;

  const ResetpasswordFailed(
      {required this.errorTitle, required this.errorMessage});
}
