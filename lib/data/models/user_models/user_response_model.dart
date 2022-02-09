// To parse this JSON data, do
//
//     final userResponseModel = userResponseModelFromJson(jsonString);

import 'dart:convert';

import '../profile/profile_seccess_model.dart';

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

class UserResponseModel {
  UserResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final UserData data;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  UserData({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.isDeviceSaved,
    required this.user,
    required this.stripeCustomerId,
  });

  final String token;
  final String tokenType;
  final int expiresIn;
  final bool isDeviceSaved;
  final User user;
  final String? stripeCustomerId;
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        isDeviceSaved: json["is_device_saved"],
        user: User.fromJson(json["user"]),
        stripeCustomerId: json['stripe_customer_id'],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "is_device_saved": isDeviceSaved,
        "stripe_customer_id": stripeCustomerId,
        "user": user.toJson(),
      };
}

