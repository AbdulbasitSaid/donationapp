import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/presentation/reusables.dart';

import '../../../../domain/repository/user_repository.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit(this._userRepository) : super(ResendOtpInitial());
  final UserRepository _userRepository;

  void resendOptCode() async {
    emit(ResendOtpLoading());
    final result = await _userRepository.resendOtpCode();
    emit(result.fold((l) => ResendOtpFailed(getErrorMessage(l.appErrorType)),
        (r) => ResendOtpSuccess(r)));
  }
}
