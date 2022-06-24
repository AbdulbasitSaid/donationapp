import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/countries_model.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../domain/repository/countries_repository.dart';

part 'getcountreis_state.dart';

class GetcountreisCubit extends Cubit<GetcountreisState> {
  GetcountreisCubit(this._countriesRepository) : super(GetcountreisInitial());
  final CountriesRepository _countriesRepository;
  void getCountries() async {
    emit(GetcountreisLoading());
    final eitherResponse = await _countriesRepository.getCountry();
    emit(eitherResponse.fold((l) {
      final errorMessage = getError(l.appErrorType);
      return GetcountreisFailed(errorMessage: errorMessage);
    }, (r) => GetcountreisSuccessfull(countries: r)));
  }

  String getError(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.api:
        return 'Api error in getting countries';
      case AppErrorType.network:
        return 'Please check that you have internet access';
      default:
        return 'Opps something went wrong';
    }
  }
}
