part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends UserState {}

class UnAuthenticated extends UserState {}

class UnSaved extends UserState {}

class Authenticated extends UserState {}

class EmailNotVerified extends UserState {}

class NotBoarded extends UserState {
  final LocalUserObject localUserObject;

  const NotBoarded({required this.localUserObject});
}
