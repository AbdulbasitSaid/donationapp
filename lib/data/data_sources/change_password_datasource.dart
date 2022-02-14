import 'dart:convert';
import 'dart:developer';

import 'package:idonatio/data/core/api_client.dart';

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

class SuccessModel {
  SuccessModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory SuccessModel.fromRawJson(String str) =>
      SuccessModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
