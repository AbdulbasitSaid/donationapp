import 'package:json_annotation/json_annotation.dart';

import 'donation_type_model.dart';
part 'donation_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationDetails {
  late String id;
  late String donationId;
  late String donationTypeId;
  late int amount;
  late DonationType donationType;
  DonationDetails({
    required this.id,
    required this.donationId,
    required this.donationTypeId,
    required this.amount, 
    required this.donationType,
  });

  factory DonationDetails.fromJson(Map<String, dynamic> json) =>
      _$DonationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DonationDetailsToJson(this);
  @override
  String toString() {
    return 'DonationDetails(id: $id, donationId: $donationId, donationTypeId: $donationTypeId, amount: $amount, donationType: $donationType)';
  }
}
