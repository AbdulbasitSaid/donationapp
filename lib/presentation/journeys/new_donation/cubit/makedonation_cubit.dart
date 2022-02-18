import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/payment_success_model.dart';
import 'package:idonatio/data/repository/payment_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/domain/entities/app_error.dart';

part 'makedonation_state.dart';

class MakedonationCubit extends Cubit<MakedonationState> {
  MakedonationCubit(this.paymentRepository) : super(MakedonationInitial());
  final PaymentRepository paymentRepository;
  void makeDonation(Map<dynamic, dynamic> params) async {
    emit(MakedonationLoading());
    final result =
        await paymentRepository.makeDonation(getItInstance(), params);
    log(result.toString());
    emit(result.fold(
        (l) => MakedonationFailed(getErrorMessage(l.appErrorType, l)),
        (r) => MakedonationSuccess(r)));
  }

  String getErrorMessage(AppErrorType appErrorType, AppError appError) {
    switch (appErrorType) {
      case AppErrorType.api:
        return 'Api Error';
      default:
        return 'UnespectedError';
    }
  }
}
