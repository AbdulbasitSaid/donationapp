import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/user_models/payment_method_model.dart';
import 'package:idonatio/data/repository/payment_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/domain/entities/app_error.dart';

part 'get_payment_methods_state.dart';

class GetPaymentMethodsCubit extends Cubit<GetPaymentMethodsState> {
  GetPaymentMethodsCubit(this._paymentRepository)
      : super(GetPaymentMethodsInitial());
  final PaymentRepository _paymentRepository;
  void getPaymentMethods() async {
    emit(GetPaymentMethodsLoading());
    final result = await _paymentRepository.getPaymentMethods(getItInstance());
    log(result.toString());
    emit(result.fold(
        (l) => GetPaymentMethodsFailed(l.appErrorType, errorMessage: 'error'),
        (r) => GetPaymentMethodsSuccessful(r)));
  }
}
