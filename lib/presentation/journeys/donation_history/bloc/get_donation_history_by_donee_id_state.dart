part of 'get_donation_history_by_donee_id_bloc.dart';

class GetDonationHistoryByDoneeIdState extends Equatable {
  final GetDonationHistoryByDoneeIdStatus status;
  final List<DonationHistoryDatumModel> donationHistory;
  final bool hasReachedMax;
  final String message;
  final int currentPage;
  final String nextPageUrl;
  final int donationCount;
  final String doneeId;

  const GetDonationHistoryByDoneeIdState({
    this.status = GetDonationHistoryByDoneeIdStatus.initial,
    this.donationHistory = const <DonationHistoryDatumModel>[],
    this.hasReachedMax = false,
    this.message = '',
    this.currentPage = 1,
    this.nextPageUrl = '',
    this.donationCount = 0,
    this.doneeId = '',
  });

  @override
  List<Object> get props => [
        status,
        donationHistory,
        hasReachedMax,
        message,
        currentPage,
        nextPageUrl,
        donationCount,
      ];

  GetDonationHistoryByDoneeIdState copyWith({
    GetDonationHistoryByDoneeIdStatus? status,
    List<DonationHistoryDatumModel>? donationHistory,
    bool? hasReachedMax,
    String? message,
    int? currentPage,
    String? nextPageUrl,
    int? donationCount,
    String? doneeId,
  }) {
    return GetDonationHistoryByDoneeIdState(
      status: status ?? this.status,
      donationHistory: donationHistory ?? this.donationHistory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      donationCount: donationCount ?? this.donationCount,
      doneeId: doneeId ?? this.doneeId,
    );
  }

  @override
  String toString() {
    return 'GetDonationHistoryByDoneeIdState(status: $status, donationHistory: $donationHistory, hasReachedMax: $hasReachedMax, message: $message, currentPage: $currentPage, nextPageUrl: $nextPageUrl, donationCount: $donationCount, doneeId: $doneeId)';
  }
}

enum GetDonationHistoryByDoneeIdStatus {
  initial,
  loading,
  success,
  failue,
}
