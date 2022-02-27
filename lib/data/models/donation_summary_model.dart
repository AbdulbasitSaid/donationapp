import 'package:json_annotation/json_annotation.dart';
part 'donation_summary_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationSummaryModel {
  DonationSummaryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  DonationSummaryData data;
  factory DonationSummaryModel.fromJson(json) =>
      _$DonationSummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationSummaryModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationSummaryData {
  DonationSummaryData({
    required this.numberOfDonations,
    required this.averageDonationAmount,
    required this.totalDonationAmount,
  });

  double numberOfDonations;
  double averageDonationAmount;
  double totalDonationAmount;
  factory DonationSummaryData.fromJson(json) =>
      _$DonationSummaryDataFromJson(json);
  Map<String, dynamic> toJson() => _$DonationSummaryDataToJson(this);
}
