import 'package:json_annotation/json_annotation.dart';

import 'donation_models/organization_model.dart';
part 'payment_success_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PaymentSuccessModel {
  PaymentSuccessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;
  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentSuccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentSuccessModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Data {
  Data({
    required this.id,
    required this.donorId,
    required this.doneeId,
    required this.paidTransactionFee,
    required this.idonatioTransactionFee,
    required this.stripeTransactionFee,
    required this.donationMethod,
    required this.disputeStatus,
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
    required this.createdAt,
    required this.donee,
  });

  String id;
  String donorId;
  String doneeId;
  bool paidTransactionFee;
  int idonatioTransactionFee;
  int stripeTransactionFee;
  String donationMethod;
  dynamic disputeStatus;
  String donationLocation;
  String currency;
  bool isAnonymous;
  bool applyGiftAidToDonation;
  bool isPlateDonation;
  String cardLastFourDigits;
  String cardType;
  int expiryMonth;
  int expiryYear;
  String stripePaymentMethodId;
  DateTime createdAt;
  Donee donee;

  factory Data.fromJson(json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
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

  String id;
  String doneeCode;
  String firstName;
  String lastName;
  String stripeConnectedAccountId;
  DateTime dateOfBirth;
  String email;
  bool isActive;
  String countryId;
  String type;
  String jobTitle;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String phoneNumber;
  DateTime verifiedAt;
  Organization organization;

  factory Donee.fromJson(json) => _$DoneeFromJson(json);
  Map<String, dynamic> toJson() => _$DoneeToJson(this);
}
