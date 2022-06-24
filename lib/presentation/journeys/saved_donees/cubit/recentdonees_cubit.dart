import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/donation_models/recent_donees_model.dart';
import '../../../../domain/repository/recent_doness_repository.dart';
import '../../../reusables.dart';

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
}
