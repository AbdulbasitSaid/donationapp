import 'package:json_annotation/json_annotation.dart';

import 'donee_model.dart';
part 'donation_history_by_donee_id_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationHistoryByDoneeIdModel {
  DonationHistoryByDoneeIdModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<DonationHistoryByDoneeIdData> data;
  factory DonationHistoryByDoneeIdModel.fromJson(json) =>
      _$DonationHistoryByDoneeIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationHistoryByDoneeIdData {
  DonationHistoryByDoneeIdData({
    required this.id,
    required this.donorId,
    required this.doneeId,
    required this.currency,
    required this.createdAt,
    required this.donationDetails,
    required this.donee,
    required this.rank,
    required this.paidTransactionFee,
    required this.idonatioTransactionFee,
    required this.stripeTransactionFee,
  });

  String id;
  String donorId;
  String doneeId;
  String currency;
  DateTime createdAt;
  double idonatioTransactionFee;
  double stripeTransactionFee;
  bool paidTransactionFee;
  int rank;
  List<DonationDetail> donationDetails;
  Donee donee;
  factory DonationHistoryByDoneeIdData.fromJson(json) =>
      _$DonationHistoryByDoneeIdDataFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdDataToJson(this);
  String get displayDationType {
    return donationDetails.length > 1
        ? 'Multiple donation types'
        : donationDetails.first.donationType.type;
  }

  double get totalPayment {
    return paidTransactionFee
        ? totalAmount + stripeTransactionFee + idonatioTransactionFee
        : totalAmount;
  }

  double get totalAmount {
    return donationDetails
        .map((e) => e.amount)
        .toList()
        .reduce((value, element) => value + element);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationDetail {
  DonationDetail({
    required this.id,
    required this.donationId,
    required this.donationTypeId,
    required this.amount,
    required this.donationType,
  });

  String id;
  String donationId;
  String donationTypeId;
  double amount;
  DonationType donationType;
  factory DonationDetail.fromJson(json) => _$DonationDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DonationDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationType {
  DonationType({
    required this.id,
    required this.doneeId,
    required this.type,
    required this.description,
    required this.giftAidEligible,
    required this.isActive,
  });

  String id;
  String doneeId;
  String type;
  String description;
  bool giftAidEligible;
  bool isActive;
  factory DonationType.fromJson(json) => _$DonationTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DonationTypeToJson(this);
}
