part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class UnSignedAuthenticated extends AuthState {}

class Boarded extends AuthState {}

class NotBoarded extends AuthState {}

class EmailVerified extends AuthState {}

class EmailNotVerified extends AuthState {}
