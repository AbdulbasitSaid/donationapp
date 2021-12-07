
import 'package:flutter/material.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future loginWithEmail(Map<String, dynamic> requestBody);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDatasource {
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> loginWithEmail(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      '/auth/login',
      params: requestBody,
    );
    debugPrint(response);
    // ignore: avoid_print
    return UserModel.fromJson(response);
  }
}
