part of 'donation_history_summary_cubit.dart';

abstract class DonationHistorySummaryState extends Equatable {
  const DonationHistorySummaryState();

  @override
  List<Object> get props => [];
}

class DonationHistorySummaryInitial extends DonationHistorySummaryState {}

class DonationHistorySummaryLoading extends DonationHistorySummaryState {}

class DonationHistorySummarySuccess extends DonationHistorySummaryState {
  final DonationSummaryModel summaryModel;

  const DonationHistorySummarySuccess(this.summaryModel);
}

class DonationHistorySummaryFailure extends DonationHistorySummaryState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const DonationHistorySummaryFailure(
      {required this.errorMessage, required this.appErrorType});
}
