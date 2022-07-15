part of 'donation_history_bloc.dart';

abstract class DonationHistoryEvent extends Equatable {
  const DonationHistoryEvent();

  @override
  List<Object> get props => [];
}

class DonationHistoryFetched extends DonationHistoryEvent {
  const DonationHistoryFetched();
}

class DonationHistoryRefreshed extends DonationHistoryEvent {
  const DonationHistoryRefreshed();
}
