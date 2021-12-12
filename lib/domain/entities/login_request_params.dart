// To parse this JSON data, do
//
//     final loginRequestParams = loginRequestParamsFromJson(jsonString);

import 'dart:convert';

LoginRequestParams loginRequestParamsFromJson(String str) =>
    LoginRequestParams.fromJson(json.decode(str));

String loginRequestParamsToJson(LoginRequestParams data) =>
    json.encode(data.toJson());

class LoginRequestParams {
  LoginRequestParams({
    required this.email,
    required this.password,
    required this.platform,
    required this.deviceUid,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.ipAddress,
    required this.screenResolution,
  });

  final String email;
  final String password;
  final String platform;
  final String deviceUid;
  final String os;
  final String osVersion;
  final String model;
  final String ipAddress;
  final String screenResolution;

  factory LoginRequestParams.fromJson(Map<String, dynamic> json) =>
      LoginRequestParams(
        email: json["email"],
        password: json["password"],
        platform: json["platform"],
        deviceUid: json["device_uid"],
        os: json["os"],
        osVersion: json["os_version"],
        model: json["model"],
        ipAddress: json["ip_address"],
        screenResolution: json["screen_resolution"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "platform": platform,
        "device_uid": deviceUid,
        "os": os,
        "os_version": osVersion,
        "model": model,
        "ip_address": ipAddress,
        "screen_resolution": screenResolution,
      };
}
