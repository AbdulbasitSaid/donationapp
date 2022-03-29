import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._userRepository) : super(ResetPasswordInitial());
  final UserRepository _userRepository;
  void resetPassword({
    required String password,
    required String email,
    required String passwordToken,
  }) async {
    emit(ResetPasswordLoading());
    final result = await _userRepository.resetPassword(
        password: password, email: email, passwordToken: passwordToken);
    emit(result.fold(
        (l) => ResetPasswordFailed(getErrorMessage(l.appErrorType)),
        (r) => ResetPasswordSuccess(r.message)));
  }
}
