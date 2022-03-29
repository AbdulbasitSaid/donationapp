import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'validate_otp_forgot_password_state.dart';

class ValidateOtpForgotPasswordCubit
    extends Cubit<ValidateOtpForgotPasswordState> {
  ValidateOtpForgotPasswordCubit(this._userRepository)
      : super(ValidateOtpForgotPasswordInitial());
  final UserRepository _userRepository;
  void validateOtpForgotPassword(
      {required String otp, required String email}) async {
    emit(ValidateOtpForgotPasswordLoading());
    final result = await _userRepository.valiteOtpForgotPassword(otp, email);
    emit(result.fold(
        (l) => ValidateOtpForgotPasswordFailed(getErrorMessage(l.appErrorType)),
        (r) => ValidateOtpForgotPasswordSuccess(r.message)));
  }
}
