import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'send_otp_forgot_password_state.dart';

class SendOtpForgotPasswordCubit extends Cubit<SendOtpForgotPasswordState> {
  SendOtpForgotPasswordCubit(this._userRepository)
      : super(SendOtpForgotPasswordInitial());
  final UserRepository _userRepository;
  void sendOtpForgotPassword({required String email}) async {
    emit(SendOtpForgotPasswordLoading());
    final result = await _userRepository.sendEmailForgotPassword(email);
    emit(result.fold(
        (l) => SendOtpForgotPasswordFailed(getErrorMessage(l.appErrorType)),
        (r) => SendOtpForgotPasswordSuccess(r.message)));
  }
}
