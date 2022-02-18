part of 'donation_process_cubit.dart';

abstract class DonationProcessState extends Equatable {
  const DonationProcessState();

  @override
  List<Object> get props => [];
}

class DonationProcessInitial extends DonationProcessState {}

class DonationProcessLoading extends DonationProcessState {}

class DonationProcessFailed extends DonationProcessState {}

class DonationProcessSuccess extends DonationProcessState {
  final DonationProcessEntity donationProcessEntity;

  const DonationProcessSuccess(this.donationProcessEntity);
}
