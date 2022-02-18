// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  UpdateProfileResponseData data;

  factory UpdateProfileResponseModel.fromRawJson(String str) =>
      UpdateProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: UpdateProfileResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UpdateProfileResponseData {
  UpdateProfileResponseData({
    required this.user,
  });

  UserModel user;

  factory UpdateProfileResponseData.fromRawJson(String str) =>
      UpdateProfileResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileResponseData.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseData(
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}
