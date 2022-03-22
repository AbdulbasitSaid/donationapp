part of 'get_donation_fees_cubit.dart';

@immutable
abstract class GetDonationFeesState {}

class GetDonationFeesInitial extends GetDonationFeesState {}
class GetDonationFeesLoading extends GetDonationFeesState {}
class GetDonationFeesSuccess extends GetDonationFeesState {
  final FeesModel feesModel;

  GetDonationFeesSuccess(this.feesModel);
}
class GetDonationFeesFailed extends GetDonationFeesState {
  final String errorMessage;

  GetDonationFeesFailed(this.errorMessage);
}
