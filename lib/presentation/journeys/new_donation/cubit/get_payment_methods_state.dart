part of 'get_payment_methods_cubit.dart';

abstract class GetPaymentMethodsState extends Equatable {
  const GetPaymentMethodsState();

  @override
  List<Object> get props => [];
}

class GetPaymentMethodsInitial extends GetPaymentMethodsState {}

class GetPaymentMethodsLoading extends GetPaymentMethodsState {}

class GetPaymentMethodsSuccessful extends GetPaymentMethodsState {
  final PaymentMethodsModel paymentMethods;

  const GetPaymentMethodsSuccessful(this.paymentMethods);
}

class GetPaymentMethodsFailed extends GetPaymentMethodsState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const GetPaymentMethodsFailed(this.appErrorType, {required this.errorMessage});
}
