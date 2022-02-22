import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';

class DonationDataSources {
  final ApiClient _apiClient;

  DonationDataSources(this._apiClient);
  Future<DonationHistoryModel> getDonationHistory(
      String token, String? params) async {
    final result =
        await _apiClient.get('donors/donations?search=$params', token: token);
    log(result.toString());
    return DonationHistoryModel.fromJson(result);
  }
}
