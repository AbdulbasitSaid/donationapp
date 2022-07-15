part of 'donation_history_bloc.dart';

class DonationHistoryState extends Equatable {
  const DonationHistoryState({
    this.status = DonationHistoryStatus.initial,
    this.donationHistory = const <DonationHistoryDatumModel>[],
    this.hasReachedMax = false,
    this.message = '',
    this.currentPage = 1,
    this.nextPageUrl,
  });
  final DonationHistoryStatus status;
  final List<DonationHistoryDatumModel> donationHistory;
  final bool hasReachedMax;
  final String message;
  final int currentPage;
  final String? nextPageUrl;

  @override
  List<Object> get props => [
        status,
        donationHistory,
        hasReachedMax,
        message,
      ];

  @override
  String toString() {
    return 'DonationHistoryState(status: $status, donationHistory: $donationHistory, hasReachedMax: $hasReachedMax, message: $message, currentPage: $currentPage, nextPageUrl: $nextPageUrl)';
  }

  DonationHistoryState copyWith({
    DonationHistoryStatus? status,
    List<DonationHistoryDatumModel>? donationHistory,
    bool? hasReachedMax,
    String? message,
    int? currentPage,
    String? nextPageUrl,
  }) {
    return DonationHistoryState(
      status: status ?? this.status,
      donationHistory: donationHistory ?? this.donationHistory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }
}

enum DonationHistoryStatus {
  initial,
  success,
  failue,
}
