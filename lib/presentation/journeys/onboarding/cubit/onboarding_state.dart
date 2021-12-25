part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingSuccess extends OnboardingState {
  final String successMessage;

  const OnboardingSuccess(this.successMessage);
}

class OnboardingFailure extends OnboardingState {
  final String errorMessage;

  const OnboardingFailure(this.errorMessage);
}
