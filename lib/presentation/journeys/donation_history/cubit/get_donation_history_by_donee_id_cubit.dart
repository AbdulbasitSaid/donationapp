import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/donation_models/donation_history_by_donee_id_model.dart';
import 'package:idonatio/data/repository/donations_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'get_donation_history_by_donee_id_state.dart';

class GetDonationHistoryByDoneeIdCubit
    extends Cubit<GetDonationHistoryByDoneeIdState> {
  final DonationRepository _donationRepository;
  GetDonationHistoryByDoneeIdCubit(this._donationRepository)
      : super(GetDonationHistoryByDoneeIdInitial());
  void getDonationHistorByDoneeId(String doneeId) async {
    emit(GetDonationHistoryByDoneeIdLoading());
    final result =
        await _donationRepository.getDonationHistoryByDoneeId(doneeId: doneeId);
    emit(result.fold(
        (l) => GetDonationHistoryByDoneeIdFailure(
            getErrorMessage(l.appErrorType), l.appErrorType),
        (r) => GetDonationHistoryByDoneeIdSuccess(r)));
  }
}
