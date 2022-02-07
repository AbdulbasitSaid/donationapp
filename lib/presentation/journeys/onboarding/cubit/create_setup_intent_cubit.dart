
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/payment_repository.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/set_up_intent_entity.dart';

part 'create_setup_intent_state.dart';

class CreateSetupIntentCubit extends Cubit<CreateSetupIntentState> {
  CreateSetupIntentCubit(this._paymentRepository)
      : super(CreateSetupIntentInitial());
  final PaymentRepository _paymentRepository;
  Future<void> createSetupIntent() async {
    emit(CreateSetupIntentLoading());
    final response = await _paymentRepository.createSetupIntent();
    emit(response.fold((l) {
      return const CreateSetupIntentFailed(
          errorMessage: 'Failed to create set up please try again');
    }, (r) {
      return CreateSetupIntentSuccessful(r);
    }));
  }
}
