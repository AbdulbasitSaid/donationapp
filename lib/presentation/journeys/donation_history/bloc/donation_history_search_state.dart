part of 'donation_history_search_bloc.dart';

class DonationHistorySearchState extends Equatable {
  const DonationHistorySearchState({
    this.status = DonationHistorySearchedStatus.initial,
    this.donationHistory = const <DonationHistoryDatumModel>[],
    this.hasReachedMax = false,
    this.message = '',
    this.currentPage = 1,
    this.nextPageUrl = '',
    this.searchQuery = '',
    this.donationCount = 0,
  });

  final DonationHistorySearchedStatus status;
  final List<DonationHistoryDatumModel> donationHistory;
  final bool hasReachedMax;
  final String message;
  final int currentPage;
  final String nextPageUrl;
  final String searchQuery;
  final int donationCount;
  
  @override
  List<Object> get props => [
        status,
        donationCount,
        donationHistory,
        hasReachedMax,
        message,
        currentPage,
        searchQuery,
      ];

  @override
  String toString() {
    return 'DonationHistorySearchState(status: $status, donationHistory: $donationHistory, hasReachedMax: $hasReachedMax, message: $message, currentPage: $currentPage, nextPageUrl: $nextPageUrl, searchQuery: $searchQuery, donationCount: $donationCount)';
  }

  DonationHistorySearchState copyWith({
    DonationHistorySearchedStatus? status,
    List<DonationHistoryDatumModel>? donationHistory,
    bool? hasReachedMax,
    String? message,
    int? currentPage,
    String? nextPageUrl,
    String? searchQuery,
    int? donationCount,
  }) {
    return DonationHistorySearchState(
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

enum DonationHistorySearchedStatus {
  initial,
  loading,
  success,
  failue,
}
