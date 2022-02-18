// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.data,
  });

  final UserData data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
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
  });

  final String token;
  final String tokenType;
  final int expiresIn;
  final bool isDeviceSaved;
  final User user;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        isDeviceSaved: json["is_device_saved"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "is_device_saved": isDeviceSaved,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
  });

  final String id;
  final String email;
  final bool isActive;
  final dynamic emailVerifiedAt;
  final Donor donor;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: json["email_verified_at"],
        donor: Donor.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt,
        "donor": donor.toJson(),
      };
}

class Donor {
  Donor({
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
  final bool phoneReceiveSecurityAlert;
  final bool giftAidEnabled;
  final dynamic address;
  final dynamic city;
  final dynamic county;
  final dynamic postalCode;
  final dynamic countryId;
  final dynamic paymentMethod;
  final bool sendMarketingMail;

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
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
