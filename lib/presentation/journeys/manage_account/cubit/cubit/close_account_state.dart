part of 'close_account_cubit.dart';

abstract class CloseAccountState extends Equatable {
  const CloseAccountState();

  @override
  List<Object> get props => [];
}

class CloseAccountInitial extends CloseAccountState {}

class CloseAccountLoading extends CloseAccountState {}

class CloseAccountSuccess extends CloseAccountState {
  final String successMessage;

  const CloseAccountSuccess(this.successMessage);
}

class CloseAccountFailed extends CloseAccountState {
  final String errorMessage;

  const CloseAccountFailed(this.errorMessage);
}
