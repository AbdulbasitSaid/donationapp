part of 'get_donation_history_by_donee_id_bloc.dart';

abstract class GetDonationHistoryByDoneeIdEvent extends Equatable {
  const GetDonationHistoryByDoneeIdEvent();

  @override
  List<Object> get props => [];
}

class GetDonationHistoryByDoneeIdFetched
    extends GetDonationHistoryByDoneeIdEvent {
  final String id;

  const GetDonationHistoryByDoneeIdFetched({required this.id});
}
