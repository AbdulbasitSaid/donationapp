import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/donation_models/donation_aggregate_model.dart';
import 'package:idonatio/domain/repository/donations_repository.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'donation_aggregation_state.dart';

class DonationAggregationCubit extends Cubit<DonationAggregationState> {
  final DonationRepository _donationRepository;
  DonationAggregationCubit(this._donationRepository)
      : super(DonationAggregationInitial());
  void getDonationAggregate() async {
    emit(DonationAggregationInitial());
    final result = await _donationRepository.getDonationAggregation();
    emit(result.fold(
        (l) => DonationAggregationFailed(getErrorMessage(l.appErrorType)),
        (r) => DonationAggregationSuccess(r)));
  }
}
