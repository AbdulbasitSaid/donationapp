import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repository/user_repository.dart';
import '../../../reusables.dart';

part 'resend_otp_forgot_password_state.dart';

class ResendOtpForgotPasswordCubit extends Cubit<ResendOtpForgotPasswordState> {
  ResendOtpForgotPasswordCubit(this._userRepository)
      : super(ResendOtpForgotPasswordInitial());
  final UserRepository _userRepository;
  void sendOtpForgotPassword({required String email}) async {
    emit(ResendOtpForgotPasswordLoading());
    final result = await _userRepository.sendEmailForgotPassword(email);
    emit(result.fold(
        (l) => ResendOtpForgotPasswordFailed(getErrorMessage(l.appErrorType)),
        (r) => ResendOtpForgotPasswordSuccess(r.message)));
  }
}
