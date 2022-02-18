part of 'onboardingdataholder_cubit.dart';

abstract class OnboardingdataholderState extends Equatable {
  const OnboardingdataholderState();

  @override
  List<Object> get props => [];
}

class OnboardingdataholderInitial extends OnboardingdataholderState {}

class OnboardingdataUpdated extends OnboardingdataholderState {
  final OnboardingEntity onboardingEntity;

  const OnboardingdataUpdated({required this.onboardingEntity});

  OnboardingdataUpdated copyWith(OnboardingEntity? onboardingEntity) {
    return OnboardingdataUpdated(
        onboardingEntity: onboardingEntity ?? this.onboardingEntity);
  }

  @override
  List<Object> get props => [onboardingEntity];
}
