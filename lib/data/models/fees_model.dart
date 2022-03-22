import 'package:json_annotation/json_annotation.dart';
part 'fees_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FeesModel {
  FeesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<FeeData> data;
  factory FeesModel.fromJson(json) => _$FeesModelFromJson(json);
  Map<String, dynamic> toJson() => _$FeesModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FeeData {
  FeeData({
    required this.id,
    required this.tag,
    required this.description,
    required this.belongsTo,
    required this.value,
    required this.isVisible,
    required this.type,
  });

  String id;
  String tag;
  String description;
  String belongsTo;
  double value;
  int isVisible;
  String type;
  factory FeeData.fromJson(json) => _$FeeDataFromJson(json);
  Map<String, dynamic> toJson() => _$FeeDataToJson(this);
}
