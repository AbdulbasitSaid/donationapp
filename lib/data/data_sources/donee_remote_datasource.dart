import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/base_success_model.dart';

import '../models/donation_models/donee_response_model.dart';

class DoneeRemoteDataSource {
  final ApiClient _apiClient;

  DoneeRemoteDataSource(this._apiClient);

  Future<DoneeResponseModel> getDoneeByCode(
      String userToken, String code) async {
    final response =
        await _apiClient.get('donees/code/$code', token: userToken);
    log(response.toString());
    return DoneeResponseModel.fromJson(response);
  }

  Future<SuccessModel> deleteSavedDonee(
      String userToken, String doneeId) async {
    final response = await _apiClient
        .deleteWithBody('donors/saved-donees/$doneeId', token: userToken);
    return SuccessModel.fromJson(response);
  }
}
