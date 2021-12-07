import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_steps_state.dart';

class RegistrationStepsCubit extends Cubit<RegistrationStepsState> {
  RegistrationStepsCubit() : super(const RegistrationStepsState(stage: 1));
  void nextStage() {
    emit(RegistrationStepsState(stage: state.stage + 1));
  }

  void previousStage() {
    emit(RegistrationStepsState(stage: state.stage - 1));
  }
}
