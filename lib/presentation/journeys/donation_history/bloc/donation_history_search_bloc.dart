import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'donation_history_search_event.dart';
part 'donation_history_search_state.dart';

class DonationHistorySearchBloc
    extends Bloc<DonationHistorySearchEvent, DonationHistorySearchState> {
  final DonationRepository _donationRepository;
  DonationHistorySearchBloc(this._donationRepository)
      : super(DonationHistorySearchInitial()) {
    on<DoantionHistorySearched>((DoantionHistorySearched event, emit) async {
      emit(DonationHistorySearchInitial());
      final result = await _donationRepository.searchDonationHistory(
          searchQuery: event.searchString);
      emit(result.fold(
          (l) => DonationHistorySearchFailed(getErrorMessage(l.appErrorType)),
          (r) => DonationHistorySearchSuccessful(r)));
    });
  }
}
