import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/donee_models/saved_donees_model.dart';
import 'package:idonatio/data/repository/saved_donees_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

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
