import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_donation_fees_state.dart';

class GetDonationFeesCubit extends Cubit<GetDonationFeesState> {
  GetDonationFeesCubit() : super(GetDonationFeesInitial());
}
