import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';

import '../models/user_models/profile_response_model.dart';

class ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSource(this.apiClient);

  Future<UpdateProfileResponseModel> updateProfile(
      String token, Map<dynamic, dynamic> params) async {
    final result =
        await apiClient.patch('donors/profile', token: token, params: params);
    log(result.toString());
    return UpdateProfileResponseModel.fromJson(result);
  }
}
