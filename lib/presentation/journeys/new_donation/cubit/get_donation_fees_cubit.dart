import 'package:bloc/bloc.dart';
import 'package:idonatio/data/models/fees_model.dart';
import 'package:idonatio/data/repository/donations_repository.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:meta/meta.dart';

part 'get_donation_fees_state.dart';

class GetDonationFeesCubit extends Cubit<GetDonationFeesState> {
  GetDonationFeesCubit(this._donationRepository)
      : super(GetDonationFeesInitial());
  final DonationRepository _donationRepository;
  void getFees() async {
    emit(GetDonationFeesLoading());
    final result = await _donationRepository.getDonationFees();
    emit(result.fold(
        (l) => GetDonationFeesFailed(getErrorMessage(l.appErrorType)),
        (r) => GetDonationFeesSuccess(r)));
  }
}
