part of 'create_setup_intent_cubit.dart';

abstract class CreateSetupIntentState extends Equatable {
  const CreateSetupIntentState();

  @override
  List<Object> get props => [];
}

class CreateSetupIntentInitial extends CreateSetupIntentState {}

class CreateSetupIntentLoading extends CreateSetupIntentState {}

class CreateSetupIntentSuccessful extends CreateSetupIntentState {
  final SetUpIntentModel setUpIntentEnitityData;

  const CreateSetupIntentSuccessful(this.setUpIntentEnitityData);
}

class CreateSetupIntentFailed extends CreateSetupIntentState {
  final String errorMessage;

  const CreateSetupIntentFailed({required this.errorMessage});
}
