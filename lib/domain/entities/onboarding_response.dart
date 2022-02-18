// To parse this JSON data, do
//
//     final onboardingResponse = onboardingResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OnboardingResponse onboardingResponseFromJson(String str) =>
    OnboardingResponse.fromJson(json.decode(str));

String onboardingResponseToJson(OnboardingResponse data) =>
    json.encode(data.toJson());

class OnboardingResponse {
  OnboardingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Data data;

  factory OnboardingResponse.fromJson(Map<String, dynamic> json) =>
      OnboardingResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isOnboarded,
    required this.title,
    required this.phoneNumber,
    required this.phoneVerifiedAt,
    required this.phoneReceiveSecurityAlert,
    required this.giftAidEnabled,
    required this.address,
    required this.city,
    required this.county,
    required this.postalCode,
    required this.countryId,
    required this.paymentMethod,
    required this.sendMarketingMail,
  });

  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final bool isOnboarded;
  final String title;
  final String? phoneNumber;
  final dynamic phoneVerifiedAt;
  final bool? phoneReceiveSecurityAlert;
  final bool? giftAidEnabled;
  final String? address;
  final String? city;
  final String? county;
  final String? postalCode;
  final String? countryId;
  final String? paymentMethod;
  final bool? sendMarketingMail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isOnboarded: json["is_onboarded"],
        title: json["title"],
        phoneNumber: json["phone_number"],
        phoneVerifiedAt: json["phone_verified_at"],
        phoneReceiveSecurityAlert: json["phone_receive_security_alert"],
        giftAidEnabled: json["gift_aid_enabled"],
        address: json["address"],
        city: json["city"],
        county: json["county"],
        postalCode: json["postal_code"],
        countryId: json["country_id"],
        paymentMethod: json["payment_method"],
        sendMarketingMail: json["send_marketing_mail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "is_onboarded": isOnboarded,
        "title": title,
        "phone_number": phoneNumber,
        "phone_verified_at": phoneVerifiedAt,
        "phone_receive_security_alert": phoneReceiveSecurityAlert,
        "gift_aid_enabled": giftAidEnabled,
        "address": address,
        "city": city,
        "county": county,
        "postal_code": postalCode,
        "country_id": countryId,
        "payment_method": paymentMethod,
        "send_marketing_mail": sendMarketingMail,
      };
}
