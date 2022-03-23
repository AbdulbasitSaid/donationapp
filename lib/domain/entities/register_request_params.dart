// To parse this JSON data, do
//
//     final registerUserRequestParameter = registerUserRequestParameterFromJson(jsonString);

import 'dart:convert';

RegisterUserRequestParameter registerUserRequestParameterFromJson(String str) =>
    RegisterUserRequestParameter.fromJson(json.decode(str));

String registerUserRequestParameterToJson(RegisterUserRequestParameter data) =>
    json.encode(data.toJson());

class RegisterUserRequestParameter {
  RegisterUserRequestParameter({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
     this.platform,
     this.deviceUid,
     this.os,
     this.osVersion,
     this.model,
     this.ipAddress,
     this.screenResolution,
  });

  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String? platform;
  final String? deviceUid;
  final String? os;
  final String? osVersion;
  final String? model;
  final String? ipAddress;
  final String? screenResolution;

  factory RegisterUserRequestParameter.fromJson(Map<String, dynamic> json) =>
      RegisterUserRequestParameter(
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        platform: json["platform"],
        deviceUid: json["device_uid"],
        os: json["os"],
        osVersion: json["os_version"],
        model: json["model"],
        ipAddress: json["ip_address"],
        screenResolution: json["screen_resolution"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "platform": platform,
        "device_uid": deviceUid,
        "os": os,
        "os_version": osVersion,
        "model": model,
        "ip_address": ipAddress,
        "screen_resolution": screenResolution,
      };

  RegisterUserRequestParameter copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phoneNumber,
    String? platform,
    String? deviceUid,
    String? os,
    String? osVersion,
    String? model,
    String? ipAddress,
    String? screenResolution,
  }) {
    return RegisterUserRequestParameter(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      platform: platform ?? this.platform,
      deviceUid: deviceUid ?? this.deviceUid,
      os: os ?? this.os,
      osVersion: osVersion ?? this.osVersion,
      model: model ?? this.model,
      ipAddress: ipAddress ?? this.ipAddress,
      screenResolution: screenResolution ?? this.screenResolution,
    );
  }
}
