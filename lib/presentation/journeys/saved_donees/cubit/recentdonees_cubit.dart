import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/recent_doness_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../data/models/donation_models/recent_donees_model.dart';

part 'recentdonees_state.dart';

class GetRecentdoneesCubit extends Cubit<RecentdoneesState> {
  GetRecentdoneesCubit(this._recentDoneesRepository)
      : super(RecentdoneesInitial());
  final RecentDoneesRepository _recentDoneesRepository;
  void getRecentDonees() async {
    emit(RecentdoneesLoading());
    final result = await _recentDoneesRepository.getRecentDonees();
    emit(result.fold((l) => RecentdoneesFailed(getErrorMessage(l.appErrorType)),
        (r) => RecentdoneesSuccessful(r)));
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
