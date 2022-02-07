import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/donee_models/recent_donees_model.dart';

class RecentDoneesDataSource {
  final ApiClient _apiClient;

  RecentDoneesDataSource(this._apiClient);

  Future<RecentDoneesResponseModel> getRecentDonees(String token) async {
    final response =
        await _apiClient.get('donors/donations/recent-donees', token: token);
    log(response.toString());
    return RecentDoneesResponseModel.fromMap(response);
  }
}
