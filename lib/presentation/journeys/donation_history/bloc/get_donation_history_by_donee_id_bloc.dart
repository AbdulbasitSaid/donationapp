import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';

import '../../../../data/models/donation_models/donee_history_datum_model.dart';
import '../../../reusables.dart';

part 'get_donation_history_by_donee_id_event.dart';
part 'get_donation_history_by_donee_id_state.dart';

class GetDonationHistoryByDoneeIdBloc extends Bloc<
    GetDonationHistoryByDoneeIdEvent, GetDonationHistoryByDoneeIdState> {
  final DonationRepository _donationRepository;
  GetDonationHistoryByDoneeIdBloc(this._donationRepository)
      : super(const GetDonationHistoryByDoneeIdState()) {
    on<GetDonationHistoryByDoneeIdFetched>(
        _onGetDonationHistoryByDoneeIdFetched);
  }

  FutureOr<void> _onGetDonationHistoryByDoneeIdFetched(
      GetDonationHistoryByDoneeIdFetched event, emit) async {
    try {
      if (state.status == GetDonationHistoryByDoneeIdStatus.initial ||
          event.id.isNotEmpty && event.id != state.doneeId) {
        emit(state.copyWith(status: GetDonationHistoryByDoneeIdStatus.loading));

        final result = await _donationRepository.getDonationHistoryByDoneeId(
            doneeId: event.id, page: 1);
        emit(
          result.fold(
            (l) => state.copyWith(
              status: GetDonationHistoryByDoneeIdStatus.failue,
              donationHistory: [],
              message: getErrorMessage(l.appErrorType),
            ),
            (r) => state.copyWith(
                status: GetDonationHistoryByDoneeIdStatus.success,
                donationHistory: r.data.data,
                hasReachedMax: r.data.data.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                donationCount: r.data.total,
                doneeId: event.id),
          ),
        );
      } else if (state.donationHistory.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else if (state.hasReachedMax == true) {
        return;
      } else {
        final result = await _donationRepository.getDonationHistoryByDoneeId(
            doneeId: state.doneeId, page: state.currentPage + 1);
        emit(
          result.fold(
            (l) => state.copyWith(
              status: GetDonationHistoryByDoneeIdStatus.failue,
              donationHistory: [],
              message: getErrorMessage(l.appErrorType),
            ),
            (r) => state.copyWith(
                status: GetDonationHistoryByDoneeIdStatus.success,
                donationHistory: List.of(state.donationHistory)
                  ..addAll(r.data.data),
                hasReachedMax: r.data.data.isEmpty ? true : false,
                currentPage: r.data.currentPage,
                nextPageUrl: r.data.nextPageUrl,
                donationCount: r.data.total,
                doneeId: event.id),
          ),
        );
      }
    } on Exception {
      emit(state.copyWith(
        status: GetDonationHistoryByDoneeIdStatus.failue,
        message: 'Opps Unexpected error occured',
        donationHistory: [],
      ));
    }
  }
}
