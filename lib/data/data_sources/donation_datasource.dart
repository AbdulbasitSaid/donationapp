import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/donation_models/donation_history_by_donee_id_model.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/data/models/donation_summary_model.dart';

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

  Future<DonationSummaryModel> getDonationHistorySummary(
      String token, String? donorId) async {
    final result = await _apiClient
        .get('donors/donations/donees/$donorId/summary', token: token);
    log(result.toString());
    return DonationSummaryModel.fromJson(result);
  }

  Future<DonationHistoryByDoneeIdModel> getDonationHistoryByDoneeId(
      String token, String? donorId) async {
    final result =
        await _apiClient.get('donors/donations?donee=$donorId', token: token);
    log(result.toString());
    return DonationHistoryByDoneeIdModel.fromJson(result);
  }
}
