part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccessfull extends UpdateProfileState {
  final String successMessage;

  const UpdateProfileSuccessfull(this.successMessage);
}

class UpdateProfileFailed extends UpdateProfileState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const UpdateProfileFailed(
      {required this.errorMessage, required this.appErrorType});
}
