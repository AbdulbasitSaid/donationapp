// To parse this JSON data, do
//
//     final otpRequestParameter = otpRequestParameterFromJson(jsonString);

import 'dart:convert';

OtpRequestParameter otpRequestParameterFromJson(String str) =>
    OtpRequestParameter.fromJson(json.decode(str));

String otpRequestParameterToJson(OtpRequestParameter data) =>
    json.encode(data.toJson());

class OtpRequestParameter {
  OtpRequestParameter({
    required this.otp,
  });

  final String otp;

  factory OtpRequestParameter.fromJson(Map<String, dynamic> json) =>
      OtpRequestParameter(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
