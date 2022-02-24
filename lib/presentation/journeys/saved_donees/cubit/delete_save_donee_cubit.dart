import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/base_success_model.dart';
import 'package:idonatio/data/repository/donee_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'delete_save_donee_state.dart';

class DeleteSaveDoneeCubit extends Cubit<DeleteSaveDoneeState> {
  DeleteSaveDoneeCubit(this._doneeRepository) : super(DeleteSaveDoneeInitial());
  final DoneeRepository _doneeRepository;
  void deleteSavedDonee(String doneeId) async {
    emit(DeleteSaveDoneeLoading());
    final result = await _doneeRepository.deleteSavedDonee(doneeId);
    emit(result.fold(
        (l) => DeleteSaveDoneeFailed(
            getErrorMessage(l.appErrorType), l.appErrorType),
        (r) => DeleteSaveDoneeSuccess(r)));
  }
}
