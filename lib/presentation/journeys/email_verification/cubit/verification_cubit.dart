import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(
    this._authenticationRepository,
    this.authBloc,
  ) : super(VerificationInitial());
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription authBlocSub;
  final AuthBloc authBloc;
  void verifyOtp(String otp) async {
    emit(VerificationLoading());
    try {
      await _authenticationRepository.verifyEmail({'otp': otp});
      authBlocSub = authBloc.stream.listen((state) {
        if (state is VerificationSuccess) {
          authBloc.add(const ChangeAuth(AuthStatus.verifiedEmail));
        }
      });

      emit(const VerificationSuccess(successMessage: 'Verified successfully.'));
    } on BadRequest {
      emit(const VerificationFailure(
          errorMessage: 'OTP has expired. Try requesting for OTP again.'));
    } on Forbidden {
      emit(const VerificationFailure(errorMessage: 'Invalid OTP.'));
    } on Exception {
      emit(const VerificationFailure(
          errorMessage: 'Ops Something went wrong.!'));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
