import 'package:json_annotation/json_annotation.dart';
part 'donation_type_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DonationTypeModel {
  late String id;
  late String doneeId;
  late String? type;
  late String? name;
  late String description;
  late bool giftAidEligible;
  late bool isActive;

  DonationTypeModel(
      {required this.id,
      required this.doneeId,
      required this.type,
      required this.description,
      required this.giftAidEligible,
      required this.isActive});

  factory DonationTypeModel.fromJson(Map<String, dynamic> json) =>
      _$DonationTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationTypeModelToJson(this);
}
