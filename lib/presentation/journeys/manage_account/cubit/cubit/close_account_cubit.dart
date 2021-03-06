import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/presentation/reusables.dart';

import '../../../../../domain/repository/user_repository.dart';

part 'close_account_state.dart';

class CloseAccountCubit extends Cubit<CloseAccountState> {
  final UserRepository _userRepository;
  CloseAccountCubit(this._userRepository) : super(CloseAccountInitial());
  void closeAccount() async {
    emit(CloseAccountLoading());
    final result = await _userRepository.closeAccount();
    emit(result.fold((l) => CloseAccountFailed(getErrorMessage(l.appErrorType)),
        (r) => const CloseAccountSuccess('Account closed')));
  }

  void clear() {
    emit(CloseAccountInitial());
  }
}
