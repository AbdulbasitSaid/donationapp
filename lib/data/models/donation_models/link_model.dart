import 'package:json_annotation/json_annotation.dart';
part 'link_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class LinkModel {
  LinkModel({
    required this.url,
    required this.label,
    required this.active,
  });

  final String url;
  final String label;
  final bool active;
  factory LinkModel.fromJson(json) => _$LinkModelFromJson(json);
  Map<String, dynamic> toJson() => _$LinkModelToJson(this);
}
