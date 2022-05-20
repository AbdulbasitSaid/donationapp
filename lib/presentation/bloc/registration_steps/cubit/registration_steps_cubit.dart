import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_steps_state.dart';

class RegistrationStepsCubit extends Cubit<RegistrationStepsState> {
  RegistrationStepsCubit() : super(const RegistrationStepsState(stage: 1));
  void nextStage() {
    emit(RegistrationStepsState(stage: state.stage + 1));
  }

  void previousStage() {
    emit(RegistrationStepsState(stage: state.stage - 1));
  }

  void resetStage() {
    emit(const RegistrationStepsState(stage: 1));
  }
}
