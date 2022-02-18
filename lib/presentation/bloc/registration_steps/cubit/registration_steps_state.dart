part of 'registration_steps_cubit.dart';

class RegistrationStepsState extends Equatable {
  const RegistrationStepsState({required this.stage});
  final int stage;

  @override
  List<Object?> get props => [stage];
}
