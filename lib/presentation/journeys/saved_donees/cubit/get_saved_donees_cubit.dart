import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/saved_donees_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../data/models/donation_models/saved_donees_model.dart';

part 'get_saved_donees_state.dart';

class GetSavedDoneesCubit extends Cubit<GetSavedDoneesState> {
  GetSavedDoneesCubit(this._savedDoneesRepository)
      : super(GetSavedDoneesInitial());
  final SavedDoneesRepository _savedDoneesRepository;
  void getSavedDonee() async {
    emit(GetSavedDoneesLoading());
    final result = await _savedDoneesRepository.getSavedDonee();
    emit(result.fold(
        (l) => GetSavedDoneesFailed(getErrorMessage(l.appErrorType)),
        (r) => GetSavedDoneesSuccess(r)));
  }
  void seachSavedDonee(String? search) async {
    emit(GetSavedDoneesLoading());
    final result = await _savedDoneesRepository.getSavedDonee(param:search);
    emit(result.fold(
        (l) => GetSavedDoneesFailed(getErrorMessage(l.appErrorType)),
        (r) => GetSavedDoneesSuccess(r)));
  }


  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.api:
        return 'Server Error';
      case AppErrorType.network:
        return "Network Error";
      case AppErrorType.unExpected:
        return "Session Expired";
      default:
        return "Unespected error";
    }
  }
}
