import 'package:idonatio/data/models/donation_models/donation_history_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donation_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationHistoryModel {
  DonationHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final DonationHistoryDataModel data;
  factory DonationHistoryModel.fromJson(json) =>
      _$DonationHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryModelToJson(this);
}
