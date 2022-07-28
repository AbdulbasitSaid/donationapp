part of 'donation_history_search_bloc.dart';

abstract class DonationHistorySearchEvent extends Equatable {
  const DonationHistorySearchEvent();

  @override
  List<Object> get props => [];
}

class   DonationHistorySearched extends DonationHistorySearchEvent {
  final String searchString;

  const DonationHistorySearched({
    required this.searchString,
  });
}

class DonationHistorySearchRefreshed extends DonationHistorySearchEvent {}
