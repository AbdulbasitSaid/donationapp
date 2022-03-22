part of 'get_remember_me_email_cubit.dart';

abstract class GetRememberMeEmailState extends Equatable {
  const GetRememberMeEmailState();
}

class GetRememberMeEmailInitial extends GetRememberMeEmailState {
  @override
  List<Object> get props => [];
}
class GetRememberMeEmailLoading extends GetRememberMeEmailState {
  @override
  List<Object> get props => [];
}class GetRememberMeEmailSuccessful extends GetRememberMeEmailState {
  final String email;

  const GetRememberMeEmailSuccessful(this.email);
  @override
  List<Object> get props => [];
}
class GetRememberMeEmailFailed extends GetRememberMeEmailState {
  @override
  List<Object> get props => [];
}
