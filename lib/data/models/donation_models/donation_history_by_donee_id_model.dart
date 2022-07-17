import 'package:idonatio/data/models/donation_models/donee_model.dart';
import 'package:idonatio/data/models/donation_models/link_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donation_history_by_donee_id_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DonationHistoryByDoneeIdModel {
  DonationHistoryByDoneeIdModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  DonationHistoryByDoneeIdData data;

  factory DonationHistoryByDoneeIdModel.fromJson(json) =>
      _$DonationHistoryByDoneeIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdModelToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DonationHistoryByDoneeIdData {
  DonationHistoryByDoneeIdData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<DonationHistoryByDoneeIdDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkModel> links;
  String? nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory DonationHistoryByDoneeIdData.fromJson(json) =>
      _$DonationHistoryByDoneeIdDataFromJson(json);

  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdDataToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DonationHistoryByDoneeIdDatum {
  DonationHistoryByDoneeIdDatum({
    required this.id,
    required this.donationCode,
    required this.donorId,
    required this.doneeId,
    required this.paidTransactionFee,
    required this.idonatioTransactionFee,
    required this.stripeTransactionFee,
    required this.donationMethod,
    required this.stripePaymentIntentId,
    this.type,
    required this.donationLocation,
    required this.currency,
    required this.isAnonymous,
    required this.applyGiftAidToDonation,
    required this.isPlateDonation,
    this.channel,
    required this.stripePaymentMethodId,
    required this.hasRefund,
    required this.hasClaimedGiftAid,
    required this.giftAidClaimId,
    required this.cardLastFourDigits,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
    this.note,
    required this.createdAt,
    required this.rank,
    required this.donationDetails,
    required this.donee,
  });

  String id;
  String donationCode;
  String donorId;
  String doneeId;
  bool paidTransactionFee;
  double idonatioTransactionFee;
  double stripeTransactionFee;
  String donationMethod;
  String stripePaymentIntentId;
  dynamic type;
  String donationLocation;
  String currency;
  bool isAnonymous;
  bool applyGiftAidToDonation;
  bool isPlateDonation;
  dynamic channel;
  String stripePaymentMethodId;
  bool hasRefund;
  bool? hasClaimedGiftAid;
  dynamic giftAidClaimId;
  String cardLastFourDigits;
  String cardType;
  String expiryMonth;
  String expiryYear;
  dynamic note;
  DateTime createdAt;
  int rank;
  List<DonationDetail> donationDetails;
  DoneeModel donee;

  factory DonationHistoryByDoneeIdDatum.fromJson(json) =>
      _$DonationHistoryByDoneeIdDatumFromJson(json);

  double get totalPayment => donationDetails
      .map((e) => e.amount)
      .toList()
      .reduce((value, element) => value + element);

  String get displayDationType => donationDetails.length > 1
      ? 'Multiple Donation Types'
      : donationDetails.first.donationType.type;

  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdDatumToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DonationDetail {
  DonationDetail({
    required this.id,
    required this.donationDetailCode,
    required this.donationId,
    required this.donationTypeId,
    required this.amount,
    required this.donationType,
  });

  String id;
  String donationDetailCode;
  String donationId;
  String donationTypeId;
  double amount;
  DonationType donationType;
  factory DonationDetail.fromJson(json) => _$DonationDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DonationDetailToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DonationType {
  DonationType({
    required this.id,
    required this.doneeId,
    required this.type,
    required this.description,
    required this.giftAidEligible,
    required this.isActive,
    required this.createdAt,
  });

  String id;
  String doneeId;
  String type;
  String description;
  bool giftAidEligible;
  bool isActive;
  DateTime createdAt;

  factory DonationType.fromJson(json) => _$DonationTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DonationTypeToJson(this);
}
