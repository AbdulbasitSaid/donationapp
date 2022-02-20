part of 'donation_history_cubit.dart';

abstract class DonationHistoryState extends Equatable {
  const DonationHistoryState();

  @override
  List<Object> get props => [];
}

class DonationHistoryInitial extends DonationHistoryState {}

class DonationHistoryLoading extends DonationHistoryState {}

class DonationHistorySuccess extends DonationHistoryState {
  final DonationHistoryModel donationHistoryModel;
  final String successMessage;
  const DonationHistorySuccess(
      {required this.donationHistoryModel, required this.successMessage});
}

class DonationHistoryFailed extends DonationHistoryState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const DonationHistoryFailed(
      {required this.errorMessage, required this.appErrorType});
}
