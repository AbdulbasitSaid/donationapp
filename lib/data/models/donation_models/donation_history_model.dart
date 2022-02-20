import 'package:json_annotation/json_annotation.dart';

import 'donation_details.dart';
import 'donee_model.dart';
part 'donation_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationHistoryModel {
  String status;
  String message;
  List<Data> data;

  DonationHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DonationHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$DonationHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonationHistoryModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Data {
  String id;
  String donorId;
  String doneeId;
  bool paidTransactionFee;
  double idonatioTransactionFee;
  double stripeTransactionFee;
  String? donationMethod;
  String? type;
  String? donationLocation;
  String currency;
  bool isAnonymous;
  bool applyGiftAidToDonation;
  bool isPlateDonation;
  String? stripePaymentMethodId;
  String? cardLastFourDigits;
  String? cardType;
  String? expiryMonth;
  String? expiryYear;
  DateTime createdAt;
  List<DonationDetails> donationDetails;
  Donee donee;

  Data(
      {required this.id,
      required this.donorId,
      required this.doneeId,
      required this.paidTransactionFee,
      required this.idonatioTransactionFee,
      required this.stripeTransactionFee,
      required this.donationMethod,
      required this.type,
      required this.donationLocation,
      required this.currency,
      required this.isAnonymous,
      required this.applyGiftAidToDonation,
      required this.isPlateDonation,
      required this.stripePaymentMethodId,
      required this.cardLastFourDigits,
      required this.cardType,
      required this.expiryMonth,
      required this.expiryYear,
      required this.createdAt,
      required this.donationDetails,
      required this.donee});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
