import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

import '../../../../data/models/donation_models/donee_history_datum_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'donation_history_search_event.dart';
part 'donation_history_search_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DonationHistorySearchBloc
    extends Bloc<DonationHistorySearchEvent, DonationHistorySearchState> {
  final DonationRepository _donationRepository;
  DonationHistorySearchBloc(this._donationRepository)
      : super(const DonationHistorySearchState()) {
    on<DonationHistorySearched>(_onDonationHistorySearched,
        transformer: throttleDroppable(throttleDuration));
    on<DonationHistorySearchRefreshed>(_onDonationHistoryRefreshed);
  }

  FutureOr<void> _onDonationHistoryRefreshed(
      DonationHistorySearchRefreshed event, emit) {
    emit(state.copyWith(
      status: DonationHistorySearchedStatus.initial,
      donationHistory: [],
      donationCount: 0,
      currentPage: null,
      searchQuery: '',
      message: '',
      hasReachedMax: false,
    ));
  }

  Future<void> _onDonationHistorySearched(DonationHistorySearched event,
      Emitter<DonationHistorySearchState> emit) async {
    try {
      if (state.status == DonationHistorySearchedStatus.initial ||
          event.searchString.isNotEmpty &&
              event.searchString != state.searchQuery) {
        emit(state.copyWith(status: DonationHistorySearchedStatus.loading));

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
                hasReachedMax: r.data.nextPageUrl.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                donationCount: r.data.total,
                searchQuery: event.searchString),
          ),
        );
      } else if (state.donationHistory.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else if (state.hasReachedMax == true) {
        return;
      } else {
        final result = await _donationRepository.searchDonationHistory(
            searchQuery: event.searchString, page: state.currentPage + 1);
        emit(
          result.fold(
            (l) => state.copyWith(
              status: DonationHistorySearchedStatus.failue,
              donationHistory: [],
              message: getErrorMessage(l.appErrorType),
            ),
            (r) => state.copyWith(
                status: DonationHistorySearchedStatus.success,
                donationHistory: List.of(state.donationHistory)
                  ..addAll(r.data.data),
                hasReachedMax: r.data.data.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                donationCount: r.data.total,
                searchQuery: event.searchString),
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
