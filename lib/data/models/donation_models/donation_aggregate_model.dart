import 'package:json_annotation/json_annotation.dart';

part 'donation_aggregate_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  createToJson: false,
)
class DonationAggrateModel {
  DonationAggrateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Data data;
  factory DonationAggrateModel.fromJson(json) =>
      _$DonationAggrateModelFromJson(json);

  @override
  String toString() =>
      'DonationAggrateModel(status: $status, message: $message, data: $data)';
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  createToJson: false,
)
class Data {
  Data({
    required this.total,
    required this.average,
  });

  final String? total;
  final String? average;
  factory Data.fromJson(json) => _$DataFromJson(json);

  @override
  String toString() => 'Data(total: $total, average: $average)';
}
