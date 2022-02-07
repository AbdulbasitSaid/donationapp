// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromMap(jsonString);

import 'dart:convert';

class PaymentSuccessModel {
  PaymentSuccessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Data data;

  factory PaymentSuccessModel.fromJson(String str) =>
      PaymentSuccessModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentSuccessModel.fromMap(Map<String, dynamic> json) =>
      PaymentSuccessModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.donorId,
    required this.doneeId,
    required this.paidTransactionFee,
    required this.donationMethod,
    required this.donationLocation,
    required this.currency,
    required this.isAnonymous,
    required this.applyGiftAidToDonation,
    required this.isPlateDonation,
    required this.cardLastFourDigits,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
    required this.stripePaymentMethodId,
  });

  final String id;
  final String donorId;
  final String doneeId;
  final bool paidTransactionFee;
  final String donationMethod;
  final String donationLocation;
  final String currency;
  final bool isAnonymous;
  final bool applyGiftAidToDonation;
  final bool isPlateDonation;
  final String cardLastFourDigits;
  final String cardType;
  final String expiryMonth;
  final String expiryYear;
  final String stripePaymentMethodId;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        donorId: json["donor_id"],
        doneeId: json["donee_id"],
        paidTransactionFee: json["paid_transaction_fee"],
        donationMethod: json["donation_method"],
        donationLocation: json["donation_location"],
        currency: json["currency"],
        isAnonymous: json["is_anonymous"],
        applyGiftAidToDonation: json["apply_gift_aid_to_donation"],
        isPlateDonation: json["is_plate_donation"],
        cardLastFourDigits: json["card_last_four_digits"],
        cardType: json["card_type"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        stripePaymentMethodId: json["stripe_payment_method_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "donor_id": donorId,
        "donee_id": doneeId,
        "paid_transaction_fee": paidTransactionFee,
        "donation_method": donationMethod,
        "donation_location": donationLocation,
        "currency": currency,
        "is_anonymous": isAnonymous,
        "apply_gift_aid_to_donation": applyGiftAidToDonation,
        "is_plate_donation": isPlateDonation,
        "card_last_four_digits": cardLastFourDigits,
        "card_type": cardType,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "stripe_payment_method_id": stripePaymentMethodId,
      };
}

class DonationDetail {
  DonationDetail({
    required this.id,
    required this.donationId,
    required this.donationTypeId,
    required this.amount,
  });

  final String id;
  final String donationId;
  final String donationTypeId;
  final int amount;

  factory DonationDetail.fromJson(String str) =>
      DonationDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DonationDetail.fromMap(Map<String, dynamic> json) => DonationDetail(
        id: json["id"],
        donationId: json["donation_id"],
        donationTypeId: json["donation_type_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "donation_id": donationId,
        "donation_type_id": donationTypeId,
        "amount": amount,
      };
}

class Donee {
  Donee({
    required this.id,
    required this.doneeCode,
    required this.firstName,
    required this.lastName,
    required this.stripeConnectedAccountId,
    required this.dateOfBirth,
    required this.email,
    required this.isActive,
    required this.countryId,
    required this.type,
    required this.jobTitle,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
    required this.verifiedAt,
    required this.organization,
  });

  final String id;
  final String doneeCode;
  final String firstName;
  final String lastName;
  final String stripeConnectedAccountId;
  final DateTime dateOfBirth;
  final String email;
  final bool isActive;
  final String countryId;
  final String type;
  final String jobTitle;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String postalCode;
  final String phoneNumber;
  final DateTime verifiedAt;
  final dynamic organization;

  factory Donee.fromJson(String str) => Donee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Donee.fromMap(Map<String, dynamic> json) => Donee(
        id: json["id"],
        doneeCode: json["donee_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        stripeConnectedAccountId: json["stripe_connected_account_id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        email: json["email"],
        isActive: json["is_active"],
        countryId: json["country_id"],
        type: json["type"],
        jobTitle: json["job_title"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        city: json["city"],
        postalCode: json["postal_code"],
        phoneNumber: json["phone_number"],
        verifiedAt: DateTime.parse(json["verified_at"]),
        organization: json["organization"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "donee_code": doneeCode,
        "first_name": firstName,
        "last_name": lastName,
        "stripe_connected_account_id": stripeConnectedAccountId,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "email": email,
        "is_active": isActive,
        "country_id": countryId,
        "type": type,
        "job_title": jobTitle,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "city": city,
        "postal_code": postalCode,
        "phone_number": phoneNumber,
        "verified_at": verifiedAt.toIso8601String(),
        "organization": organization,
      };
}
