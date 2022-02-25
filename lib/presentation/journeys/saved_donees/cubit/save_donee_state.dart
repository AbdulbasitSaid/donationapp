part of 'save_donee_cubit.dart';

abstract class SaveDoneeState extends Equatable {
  const SaveDoneeState();

  @override
  List<Object> get props => [];
}

class SaveDoneeInitial extends SaveDoneeState {}

class SaveDoneeLoading extends SaveDoneeState {}

class SaveDoneeSuccess extends SaveDoneeState {
  final SuccessModel successModel;

  const SaveDoneeSuccess(this.successModel);
}

class SaveDoneeFailed extends SaveDoneeState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const SaveDoneeFailed(this.errorMessage, this.appErrorType);
}
