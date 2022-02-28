part of 'get_donation_history_by_donee_id_cubit.dart';

abstract class GetDonationHistoryByDoneeIdState extends Equatable {
  const GetDonationHistoryByDoneeIdState();

  @override
  List<Object> get props => [];
}

class GetDonationHistoryByDoneeIdInitial
    extends GetDonationHistoryByDoneeIdState {}

class GetDonationHistoryByDoneeIdLoading
    extends GetDonationHistoryByDoneeIdState {}

class GetDonationHistoryByDoneeIdSuccess
    extends GetDonationHistoryByDoneeIdState {
  final DonationHistoryByDoneeIdModel donationHistoryByDoneeIdModel;

  const GetDonationHistoryByDoneeIdSuccess(this.donationHistoryByDoneeIdModel);
}

class GetDonationHistoryByDoneeIdFailure
    extends GetDonationHistoryByDoneeIdState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const GetDonationHistoryByDoneeIdFailure(
      this.errorMessage, this.appErrorType);
}
