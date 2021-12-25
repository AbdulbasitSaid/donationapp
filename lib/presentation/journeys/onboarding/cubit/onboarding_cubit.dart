import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this.authenticationRepository) : super(OnboardingInitial());
  final AuthenticationRepository authenticationRepository;
  void onBoardUser(Map<String, dynamic> params) async {
    emit(OnboardingLoading());

    try {
      await authenticationRepository.boardUser(params);
      emit(const OnboardingSuccess('Onboarding was successful'));
    } on UnprocessableEntity {
      emit(const OnboardingFailure('Validation error '));
    } on BadRequest {
      emit(const OnboardingFailure('Bad Reques'));
    } on Forbidden {
      emit(
          const OnboardingFailure('You have not verified your email address.'));
    } on Exception {
      emit(const OnboardingFailure('Opp some thing went wrong.!'));
    }
  }
}
