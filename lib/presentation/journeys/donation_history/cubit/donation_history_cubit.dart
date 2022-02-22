import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/data/repository/donations_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'donation_history_state.dart';

class DonationHistoryCubit extends Cubit<DonationHistoryState> {
  final DonationRepository donationRepository;
  DonationHistoryCubit(this.donationRepository)
      : super(DonationHistoryInitial());
  void getDonationHistory() async {
    emit(DonationHistoryLoading());
    final result = await donationRepository.getDonationHistory();
    emit(result.fold(
        (l) => DonationHistoryFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => DonationHistorySuccess(
            donationHistoryModel: r, successMessage: r.message)));
  }

  void searchDonationHistory(String? search) async {
    emit(DonationHistoryLoading());

    final result = await donationRepository.getDonationHistory(params: search);
    emit(result.fold(
        (l) => DonationHistoryFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => DonationHistorySuccess(
            donationHistoryModel: r, successMessage: r.message)));
  }
}
