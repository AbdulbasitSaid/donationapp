import 'package:json_annotation/json_annotation.dart';

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
  PaymentSuccessData data;
  factory PaymentSuccessModel.fromJson(json) =>
      _$PaymentSuccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentSuccessModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PaymentSuccessData {
  PaymentSuccessData({
    required this.doneeId,
    required this.donationMethod,
    required this.donationLocation,
    required this.isAnonymous,
    required this.applyGiftAidToDonation,
    required this.currency,
    required this.cardLastFourDigits,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
    required this.paidTransactionFee,
    required this.idonatioTransactionFee,
    required this.stripeTransactionFee,
    required this.stripePaymentMethodId,
    required this.donorId,
    required this.id,
    required this.createdAt,
    required this.channel,
    required this.donationDetails,
  });

  String doneeId;
  String donationMethod;
  String? channel;
  String donationLocation;
  bool isAnonymous;
  bool applyGiftAidToDonation;
  String currency;
  String cardLastFourDigits;
  String cardType;
  int expiryMonth;
  int expiryYear;
  bool paidTransactionFee;
  double idonatioTransactionFee;
  double stripeTransactionFee;
  String stripePaymentMethodId;
  String donorId;
  String id;
  DateTime createdAt;
  List<DonationDetail> donationDetails;

  factory PaymentSuccessData.fromJson(json) =>
      _$PaymentSuccessDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentSuccessDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationDetail {
  DonationDetail({
    required this.id,
    required this.donationId,
    required this.donationTypeId,
    required this.amount,
  });

  String id;
  String donationId;
  String donationTypeId;
  double amount;
  factory DonationDetail.fromJson(json) => _$DonationDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DonationDetailToJson(this);
}
