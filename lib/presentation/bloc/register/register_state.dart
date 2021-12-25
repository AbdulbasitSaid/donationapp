part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String errorMessage;

  const RegisterFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class RegisterSuccess extends RegisterState {}
