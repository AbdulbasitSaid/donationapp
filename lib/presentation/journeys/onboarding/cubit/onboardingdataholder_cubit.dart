import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/onboarding_entity.dart';

part 'onboardingdataholder_state.dart';

class OnboardingdataholderCubit extends Cubit<OnboardingdataholderState> {
  OnboardingdataholderCubit() : super(OnboardingdataholderInitial());

  void updateOnboardingData(OnboardingEntity onboardingEntity) {
    emit(OnboardingdataUpdated(onboardingEntity: onboardingEntity));
  }
}
