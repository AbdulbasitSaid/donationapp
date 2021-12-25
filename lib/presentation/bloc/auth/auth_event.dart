part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ChangeAuth extends AuthEvent {
  final AuthStatus authStatus;

   const ChangeAuth(this.authStatus);
  @override
  List<Object> get props => [authStatus];
}
