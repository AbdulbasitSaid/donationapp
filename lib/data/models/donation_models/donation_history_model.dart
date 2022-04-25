import 'package:json_annotation/json_annotation.dart';

import 'donation_details.dart';
import 'donee_model.dart';
part 'donation_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationHistoryModel {
  String status;
  String message;
  List<DonationHistoryData> data;

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
class DonationHistoryData {
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
  int rank;
  List<DonationDetails> donationDetails;
  Donee donee;
  double get totalAmount => donationDetails
      .map(
        (e) => e.amount,
      )
      .toList()
      .reduce((value, element) => value! + element!)!;
  double get totalPayment {
    return paidTransactionFee
        ? totalAmount + stripeTransactionFee + idonatioTransactionFee
        : totalAmount;
  }

  String? get displayDonationType => donationDetails.length > 1
      ? 'Multiple donation types'
      : donationDetails.first.donationType!.type;

  double get transationFee {
    final fee = idonatioTransactionFee + stripeTransactionFee;

    return paidTransactionFee ? double.parse(fee.toStringAsFixed(2)) : 0.0;
  }

  DonationHistoryData(
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
      required this.rank,
      required this.donee});

  factory DonationHistoryData.fromJson(Map<String, dynamic> json) =>
      _$DonationHistoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryDataToJson(this);
}
