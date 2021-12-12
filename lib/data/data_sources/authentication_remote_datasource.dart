import 'package:flutter/material.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/user_model.dart';

class AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSource(this._client);

  @override
  Future<UserModel> loginWithEmail(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      '/auth/login',
      params: requestBody,
    );
    return UserModel.fromJson(response);
  }
}
