import 'package:idonatio/data/models/donation_models/donee_history_datum_model.dart';
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
  List<DonationHistoryDatumModel> data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<LinkModel> links;
  String? nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  factory DonationHistoryByDoneeIdData.fromJson(json) =>
      _$DonationHistoryByDoneeIdDataFromJson(json);

  Map<String, dynamic> toJson() => _$DonationHistoryByDoneeIdDataToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
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
