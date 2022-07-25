part of 'donation_history_search_bloc.dart';

abstract class DonationHistorySearchState extends Equatable {
  const DonationHistorySearchState();

  @override
  List<Object> get props => [];
}

class DonationHistorySearchInitial extends DonationHistorySearchState {}

class DonationHistorySearchSuccessful extends DonationHistorySearchState {
  final DonationHistoryModel donationHistoryModel;

  const DonationHistorySearchSuccessful(this.donationHistoryModel);
}

class DonationHistorySearchFailed extends DonationHistorySearchState {
  final String errorMessage;

  const DonationHistorySearchFailed(this.errorMessage);
}
