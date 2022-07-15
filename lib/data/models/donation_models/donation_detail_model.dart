import 'package:idonatio/data/models/donation_models/donation_type_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donation_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DonationDetailModel {
  DonationDetailModel({
    required this.id,
    required this.donationDetailCode,
    required this.donationId,
    required this.donationTypeId,
    required this.amount,
    required this.donationType,
  });

  final String id;
  final String donationDetailCode;
  final String donationId;
  final String donationTypeId;
  final double amount;
  final DonationTypeModel donationType;
  factory DonationDetailModel.fromJson(json) =>
      _$DonationDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationDetailModelToJson(this);
}
