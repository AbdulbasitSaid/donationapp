import 'package:json_annotation/json_annotation.dart';
part 'referesh_token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RefereshTokenModel {
  RefereshTokenModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  RefereshTokenData data;
  factory RefereshTokenModel.fromJson(json) =>
      _$RefereshTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$RefereshTokenModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RefereshTokenData {
  RefereshTokenData({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
  });

  String token;
  String tokenType;
  int expiresIn;
  factory RefereshTokenData.fromJson(json) => _$RefereshTokenDataFromJson(json);
  Map<String, dynamic> toJson() => _$RefereshTokenDataToJson(this);
}
