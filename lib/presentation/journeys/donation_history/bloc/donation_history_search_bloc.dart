import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';

import '../../../../data/models/donation_models/donee_history_datum_model.dart';
import '../../../reusables.dart';

part 'donation_history_search_event.dart';
part 'donation_history_search_state.dart';

class DonationHistorySearchBloc
    extends Bloc<DonationHistorySearchEvent, DonationHistorySearchState> {
  final DonationRepository _donationRepository;
  DonationHistorySearchBloc(this._donationRepository)
      : super(const DonationHistorySearchState()) {
    on<DoantionHistorySearched>(_onDonationHistorySearched);
  }

  Future<void> _onDonationHistorySearched(DoantionHistorySearched event,
      Emitter<DonationHistorySearchState> emit) async {
    emit(state.copyWith(status: DonationHistorySearchedStatus.loading));
    if (state.hasReachedMax == true) {
      return;
    } else {
      try {
        if (state.status == DonationHistorySearchedStatus.initial ||
            state.status == DonationHistorySearchedStatus.loading) {
          final result = await _donationRepository.searchDonationHistory(
              searchQuery: event.searchString);
          emit(
            result.fold(
              (l) => state.copyWith(
                status: DonationHistorySearchedStatus.failue,
                donationHistory: [],
                message: getErrorMessage(l.appErrorType),
              ),
              (r) => state.copyWith(
                status: DonationHistorySearchedStatus.success,
                donationHistory: r.data.data,
                hasReachedMax: false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                searchQuery: event.searchString,
                donationCount: r.data.total,
              ),
            ),
          );
        } else if (state.donationHistory.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          final result = await _donationRepository.searchDonationHistory(
              searchQuery: event.searchString,
              page: state.searchQuery == event.searchString
                  ? state.currentPage + 1
                  : 1);
          emit(
            result.fold(
              (l) => state.copyWith(
                status: DonationHistorySearchedStatus.failue,
                donationHistory: [],
                message: getErrorMessage(l.appErrorType),
              ),
              (r) => state.copyWith(
                status: DonationHistorySearchedStatus.success,
                donationHistory: state.searchQuery != event.searchString
                    ? r.data.data
                    : List.of(state.donationHistory)
                  ..addAll(r.data.data),
                hasReachedMax: r.data.data.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                donationCount: r.data.total,
              ),
            ),
          );
        }
      } on Exception {
        emit(state.copyWith(
          status: DonationHistorySearchedStatus.failue,
          message: 'Opps Unexpected error occured',
          donationHistory: [],
        ));
      }
    }
  }
}
