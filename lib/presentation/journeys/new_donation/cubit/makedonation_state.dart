part of 'makedonation_cubit.dart';

abstract class MakedonationState extends Equatable {
  const MakedonationState();

  @override
  List<Object> get props => [];
}

class MakedonationInitial extends MakedonationState {}

class MakedonationLoading extends MakedonationState {}

class MakedonationFailed extends MakedonationState {
  final String errorMessage;

  const MakedonationFailed(this.errorMessage);
}

class MakedonationSuccess extends MakedonationState {
  final PaymentSuccessModel paymentSuccessModel;

  const MakedonationSuccess(this.paymentSuccessModel);
}
