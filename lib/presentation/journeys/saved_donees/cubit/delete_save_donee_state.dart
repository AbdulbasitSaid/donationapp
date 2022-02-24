part of 'delete_save_donee_cubit.dart';

abstract class DeleteSaveDoneeState extends Equatable {
  const DeleteSaveDoneeState();

  @override
  List<Object> get props => [];
}

class DeleteSaveDoneeInitial extends DeleteSaveDoneeState {}

class DeleteSaveDoneeLoading extends DeleteSaveDoneeState {}

class DeleteSaveDoneeSuccess extends DeleteSaveDoneeState {
  final SuccessModel successModel;

  const DeleteSaveDoneeSuccess(this.successModel);
}

class DeleteSaveDoneeFailed extends DeleteSaveDoneeState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const DeleteSaveDoneeFailed(this.errorMessage, this.appErrorType);
}
