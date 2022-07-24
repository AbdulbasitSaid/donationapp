part of 'donation_aggregation_cubit.dart';

abstract class DonationAggregationState extends Equatable {
  const DonationAggregationState();

  @override
  List<Object> get props => [];
}

class DonationAggregationInitial extends DonationAggregationState {}

class DonationAggregationSuccess extends DonationAggregationState {
  final DonationAggrateModel donationAggrateModel;

  const DonationAggregationSuccess(this.donationAggrateModel);
}

class DonationAggregationFailed extends DonationAggregationState {
  final String errorMessage;

  const DonationAggregationFailed(this.errorMessage);
}
