part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccessful extends LogoutState {}

class LogoutFailed extends LogoutState {
  final String errorMessage;

  const LogoutFailed({required this.errorMessage});
}
