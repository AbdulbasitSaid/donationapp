import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/onboarding_entity.dart';

part 'onboardingdataholder_state.dart';

class OnboardingdataholderCubit extends Cubit<OnboardingEntity> {
  OnboardingdataholderCubit() : super(const OnboardingEntity());

  void updateOnboardingData(OnboardingEntity onboardingEntity) {
    emit(onboardingEntity);
  }
}
