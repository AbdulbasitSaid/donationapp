part of 'donation_history_bloc.dart';

class DonationHistoryState extends Equatable {
  const DonationHistoryState({
    this.status = DonationHistoryStatus.initial,
    this.donationHistory = const <DonationHistoryDatumModel>[],
    this.hasReachedMax = false,
    this.message = '',
    this.currentPage = 1,
    this.nextPageUrl,
    this.searchQuery,
    this.donationCount = 0,
  });
  final DonationHistoryStatus status;
  final List<DonationHistoryDatumModel> donationHistory;
  final bool hasReachedMax;
  final String message;
  final int currentPage;
  final String? nextPageUrl;
  final String? searchQuery;
  final int donationCount;
  @override
  List<Object> get props => [
        status,
        donationHistory,
        hasReachedMax,
        message,
      ];

  @override
  String toString() {
    return 'DonationHistoryState(status: $status, donationHistory: $donationHistory, hasReachedMax: $hasReachedMax, message: $message, currentPage: $currentPage, nextPageUrl: $nextPageUrl, searchQuery: $searchQuery, donationCount: $donationCount)';
  }

  DonationHistoryState copyWith({
    DonationHistoryStatus? status,
    List<DonationHistoryDatumModel>? donationHistory,
    bool? hasReachedMax,
    String? message,
    int? currentPage,
    String? nextPageUrl,
    String? searchQuery,
    int? donationCount,
  }) {
    return DonationHistoryState(
      status: status ?? this.status,
      donationHistory: donationHistory ?? this.donationHistory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      searchQuery: searchQuery ?? this.searchQuery,
      donationCount: donationCount ?? this.donationCount,
    );
  }
}

enum DonationHistoryStatus {
  initial,
  search,
  success,
  failue,
}
