part of 'donation_history_search_bloc.dart';

abstract class DonationHistorySearchEvent extends Equatable {
  const DonationHistorySearchEvent();

  @override
  List<Object> get props => [];
}

class DoantionHistorySearched extends DonationHistorySearchEvent {
  final String searchString;

  const DoantionHistorySearched(this.searchString);
}
