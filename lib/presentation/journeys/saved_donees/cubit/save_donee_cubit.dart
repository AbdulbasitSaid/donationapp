import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

import '../../../../domain/repository/donee_repository.dart';

part 'save_donee_state.dart';

class SaveDoneeCubit extends Cubit<SaveDoneeState> {
  final DoneeRepository _doneeRepository;
  SaveDoneeCubit(this._doneeRepository) : super(SaveDoneeInitial());
  void saveDonee(Map<String, dynamic> donee) async {
    emit(SaveDoneeLoading());
    final result = await _doneeRepository.saveDonee(donee);
    emit(result.fold(
        (l) => SaveDoneeFailed(getErrorMessage(l.appErrorType), l.appErrorType),
        (r) => SaveDoneeSuccess(r)));
  }
}
