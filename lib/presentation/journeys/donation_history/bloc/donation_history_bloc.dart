import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/donation_models/donee_history_datum_model.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:stream_transform/stream_transform.dart';

part 'donation_history_event.dart';
part 'donation_history_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DonationHistoryBloc
    extends Bloc<DonationHistoryEvent, DonationHistoryState> {
  final DonationRepository _donationRepository;
  DonationHistoryBloc(this._donationRepository)
      : super(const DonationHistoryState()) {
    on<DonationHistoryFetched>(_onDonationHistoryFetched,
        transformer: throttleDroppable(throttleDuration));
    on<DonationHistoryRefreshed>(_onDonationHistoryRefereshed,
        transformer: throttleDroppable(throttleDuration));
    on<DonationHistorySearched>(_onDonationHistorySearched);
  }

  Future<void> _onDonationHistoryRefereshed(DonationHistoryRefreshed event,
      Emitter<DonationHistoryState> emit) async {
    final result = await _donationRepository.getDonationHistory();
    emit(
      result.fold(
        (l) => state.copyWith(
          status: DonationHistoryStatus.failue,
          donationHistory: [],
          message: getErrorMessage(l.appErrorType),
        ),
        (r) => state.copyWith(
          status: DonationHistoryStatus.success,
          donationHistory: r.data.data,
          hasReachedMax: false,
          currentPage: r.data.currentPage,
          nextPageUrl: r.data.nextPageUrl,
        ),
      ),
    );
  }

  Future<void> _onDonationHistoryFetched(
      DonationHistoryFetched event, Emitter<DonationHistoryState> emit) async {
    if (state.hasReachedMax == true) {
      return;
    } else {
      try {
        if (state.status == DonationHistoryStatus.initial) {
          final result = await _donationRepository.getDonationHistory();
          emit(
            result.fold(
              (l) => state.copyWith(
                status: DonationHistoryStatus.failue,
                donationHistory: [],
                message: getErrorMessage(l.appErrorType),
              ),
              (r) => state.copyWith(
                status: DonationHistoryStatus.success,
                donationHistory: r.data.data,
                hasReachedMax: false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
              ),
            ),
          );
        } else if (state.donationHistory.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          final result = await _donationRepository.getDonationHistory(
            page: state.currentPage + 1,
          );
          emit(
            result.fold(
              (l) => state.copyWith(
                status: DonationHistoryStatus.failue,
                donationHistory: [],
                message: getErrorMessage(l.appErrorType),
              ),
              (r) => state.copyWith(
                status: DonationHistoryStatus.success,
                donationHistory: List.of(state.donationHistory)
                  ..addAll(r.data.data),
                hasReachedMax: r.data.data.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
              ),
            ),
          );
        }
      } on Exception {
        emit(state.copyWith(
          status: DonationHistoryStatus.failue,
          message: 'Opps Unexpected error occured',
          donationHistory: [],
        ));
      }
    }
  }

  FutureOr<void> _onDonationHistorySearched(
      DonationHistorySearched event, Emitter<DonationHistoryState> emit) async {
    {
      emit(state.copyWith(status: DonationHistoryStatus.initial));
      final result = await _donationRepository.getDonationHistory(
        searchQuery: event.searchQuery,
      );
      emit(
        result.fold(
          (l) => state.copyWith(
            status: DonationHistoryStatus.failue,
            donationHistory: [],
            message: getErrorMessage(l.appErrorType),
          ),
          (r) => state.copyWith(
            status: DonationHistoryStatus.success,
            donationHistory: r.data.data,
            currentPage: r.data.currentPage,
            nextPageUrl: r.data.nextPageUrl,
          ),
        ),
      );
    }
  }
}
