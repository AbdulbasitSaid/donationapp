import 'package:json_annotation/json_annotation.dart';
part 'donation_type_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DonationType {
  late String id;
  late String doneeId;
  late String type;
  late String description;
  late bool giftAidEligible;
  late bool isActive;

  DonationType(
      {required this.id,
      required this.doneeId,
      required this.type,
      required this.description,
      required this.giftAidEligible,
      required this.isActive});

  factory DonationType.fromJson(Map<String, dynamic> json) =>
      _$DonationTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DonationTypeToJson(this);
}
