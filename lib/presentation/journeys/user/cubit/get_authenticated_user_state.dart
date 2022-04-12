part of 'get_authenticated_user_cubit.dart';

abstract class GetAuthenticatedUserState extends Equatable {
  const GetAuthenticatedUserState();

  @override
  List<Object> get props => [];
}

class GetAuthenticatedUserInitial extends GetAuthenticatedUserState {}

class GetAuthenticatedUserLoading extends GetAuthenticatedUserState {}

class GetAuthenticatedUserSuccess extends GetAuthenticatedUserState {
  final GetAuthenticatedUserModel getAuthenticatedUserModel;
  const GetAuthenticatedUserSuccess(this.getAuthenticatedUserModel);
}

class GetAuthenticatedUserFailed extends GetAuthenticatedUserState {}
