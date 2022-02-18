part of 'contact_support_cubit.dart';

abstract class ContactSupportState extends Equatable {
  const ContactSupportState();

  @override
  List<Object> get props => [];
}

class ContactSupportInitial extends ContactSupportState {}

class ContactSupportLoading extends ContactSupportState {}

class ContactSupportSuccessful extends ContactSupportState {
  final String successMessage;

  const ContactSupportSuccessful(this.successMessage);
}

class ContactSupportFailed extends ContactSupportState {
  final String errorMessage;
  final AppErrorType appErrorType;
  const ContactSupportFailed(this.errorMessage, this.appErrorType);
}
