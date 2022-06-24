import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/donation_summary_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

import '../../../../domain/repository/donations_repository.dart';

part 'donation_history_summary_state.dart';

class DonationHistorySummaryCubit extends Cubit<DonationHistorySummaryState> {
  DonationHistorySummaryCubit(this._donationRepository)
      : super(DonationHistorySummaryInitial());
  final DonationRepository _donationRepository;
  void getDonationHistoryDetailSummary(String donorId) async {
    emit(DonationHistorySummaryLoading());
    final result =
        await _donationRepository.getDonationHistorySummary(donorId: donorId);
    emit(result.fold(
        (l) => DonationHistorySummaryFailure(
            errorMessage: getErrorMessage(l.appErrorType),
            appErrorType: l.appErrorType),
        (r) => DonationHistorySummarySuccess(r)));
  }
}
