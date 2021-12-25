import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerificationState> {
  VerifyCubit({required this.authenticationRepository})
      : super(VerificationInitial());
  final AuthenticationRepository authenticationRepository;

  void veryEmail(String otp) async {
    emit(VerificationLoading());
    try {
      await authenticationRepository.verifyEmail({'otp': otp});
      emit(const VerificationSuccess('Verified successfully.'));
    } on BadRequest {
      emit(const VerificationFailue(
          errorMessage: 'OTP has expired. Try requesting for OTP again.'));
    } on Forbidden {
      emit(const VerificationFailue(errorMessage: 'OInvalid OTP.'));
    } on Exception {
      emit(const VerificationFailue(errorMessage: 'Opps Somthing went wrong!'));
    }
  }
}
