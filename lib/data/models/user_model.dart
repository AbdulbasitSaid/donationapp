// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.userData,
  });

  final String status;
  final String message;
  final UserData userData;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userData": userData.toJson(),
      };
}

class UserData {
  UserData({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  final String token;
  final String tokenType;
  final int expiresIn;
  final UserClass user;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": user.toJson(),
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.passwordResetToken,
    required this.donor,
  });

  final String id;
  final String email;
  final bool isActive;
  final DateTime? emailVerifiedAt;
  final dynamic passwordResetToken;
  final Donor donor;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        passwordResetToken: json["password_reset_token"],
        donor: Donor.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt!=null? emailVerifiedAt!.toIso8601String():null,
        "password_reset_token": passwordResetToken,
        "donor": donor.toJson(),
      };
}

class Donor {
  Donor({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.phoneNumber,
    @required this.phoneVerifiedAt,
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
  final String title;
  final String phoneNumber;
  final dynamic phoneVerifiedAt;
  final bool phoneReceiveSecurityAlert;
  final bool giftAidEnabled;
  final String address;
  final String city;
  final String county;
  final String postalCode;
  final String countryId;
  final String paymentMethod;
  final bool sendMarketingMail;

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
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
