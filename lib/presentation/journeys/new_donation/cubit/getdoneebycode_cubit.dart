import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/donee_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../data/models/donation_models/donee_response_model.dart';
import '../../../reusables.dart';

part 'getdoneebycode_state.dart';

class GetdoneebycodeCubit extends Cubit<GetdoneebycodeState> {
  GetdoneebycodeCubit({required this.doneeRepository})
      : super(GetdoneebycodeInitial());
  final DoneeRepository doneeRepository;
  void getDoneeByCode(String doneeCode) async {
    emit(GetdoneebycodeLoading());
    final result = await doneeRepository.getDoneeById(doneeCode);
    emit(result.fold(
        (l) => GetdoneebycodeFailed(
              errorMessage: getErrorMessage(l.appErrorType),
              errorTitle: 'Error getting Donee',
              appErrorType: l.appErrorType,
            ),
        (r) => GetdoneebycodeSuccess(r.data)));
  }
}
