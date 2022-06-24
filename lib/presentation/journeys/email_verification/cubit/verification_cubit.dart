import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../domain/repository/user_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(
    this._authenticationRepository,
  ) : super(VerificationInitial());
  final UserRepository _authenticationRepository;
  late final StreamSubscription authBlocSub;
  void verifyOtp(String otp) async {
    emit(VerificationLoading());

    final Either<AppError, dynamic> either =
        await _authenticationRepository.verifyEmail({'otp': otp});
    emit(either.fold((l) {
      String errorMessage = getErrors(l.appErrorType);
      return VerificationFailure(errorMessage: errorMessage);
    },
        (r) => const VerificationSuccess(
            successMessage: 'Verified successfully.!')));
  }

  @override
  Future<void> close() {
    return super.close();
  }

  String getErrors(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.unProcessableEntity:
        return 'The otp field is required.';
      case AppErrorType.badRequest:
        return "Invalid OTP.";
      case AppErrorType.unauthorized:
        return 'Process not authorised';
      default:
        return "Ops Something went wrong!";
    }
  }
}
