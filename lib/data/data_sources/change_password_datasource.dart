import 'dart:convert';
import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';

import '../models/base_success_model.dart';

class ChangePasswordDataSource {
  final ApiClient _apiClient;

  ChangePasswordDataSource(this._apiClient);
  Future<SuccessModel> changePassword(
      Map<String, dynamic> params, String token) async {
    var result = await _apiClient.patch('auth/password/change-password',
        token: token, params: params);
    log(result.toString());
    return SuccessModel.fromJson(result);
  }
}
