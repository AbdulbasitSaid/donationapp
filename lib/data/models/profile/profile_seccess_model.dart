// To parse this JSON data, do
//
//     final profileSuccessModel = profileSuccessModelFromJson(jsonString);

import 'dart:convert';

class ProfileSuccessModel {
  String status;
  String message;
  Data data;

  ProfileSuccessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileSuccessModel.fromRawJson(String str) =>
      ProfileSuccessModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileSuccessModel.fromJson(Map<String, dynamic> json) =>
      ProfileSuccessModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };

  @override
  String toString() =>
      'ProfileSuccessModel(status: $status, message: $message, data: $data)';
}

class Data {
  User user;

  Data({
    required this.user,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };

  @override
  String toString() => 'Data(user: $user)';
}

class User {
  User({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
  });

  String id;
  String email;
  bool isActive;
  DateTime? emailVerifiedAt;
  Donor donor;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        donor: Donor.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "donor": donor.toJson(),
      };
}

class Donor {
  String id;
  String userId;
  String firstName;
  String lastName;
  bool isOnboarded;
  String title;
  String phoneNumber;
  String stripeCustomerId;
  dynamic phoneVerifiedAt;
  bool phoneReceiveSecurityAlert;
  bool giftAidEnabled;
  String address;
  String city;
  String county;
  String postalCode;
  String countryId;
  String paymentMethod;
  bool sendMarketingMail;
  bool donateAnonymously;
  Donor({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isOnboarded,
    required this.title,
    required this.phoneNumber,
    required this.stripeCustomerId,
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
    required this.donateAnonymously,
  });

  factory Donor.fromRawJson(String str) => Donor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isOnboarded: json["is_onboarded"],
        title: json["title"],
        phoneNumber: json["phone_number"],
        stripeCustomerId: json["stripe_customer_id"],
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
        donateAnonymously: json["donate_anonymously"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "is_onboarded": isOnboarded,
        "title": title,
        "phone_number": phoneNumber,
        "stripe_customer_id": stripeCustomerId,
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
        "donate_anonymously": donateAnonymously,
      };

  @override
  String toString() {
    return 'Donor(id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, isOnboarded: $isOnboarded, title: $title, phoneNumber: $phoneNumber, stripeCustomerId: $stripeCustomerId, phoneVerifiedAt: $phoneVerifiedAt, phoneReceiveSecurityAlert: $phoneReceiveSecurityAlert, giftAidEnabled: $giftAidEnabled, address: $address, city: $city, county: $county, postalCode: $postalCode, countryId: $countryId, paymentMethod: $paymentMethod, sendMarketingMail: $sendMarketingMail, donateAnonymously: $donateAnonymously)';
  }
}
