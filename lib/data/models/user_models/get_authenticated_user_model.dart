import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/user_models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_authenticated_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class GetAuthenticatedUserModel extends Equatable {
  final String status;
  final String message;
  final Data data;

  const GetAuthenticatedUserModel(
      {required this.status, required this.message, required this.data});
  factory GetAuthenticatedUserModel.fromJson(json) =>
      _$GetAuthenticatedUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAuthenticatedUserModelToJson(this);

  @override
  List<Object?> get props => [status, message, data];
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Data extends Equatable {
  final UserModel user;

  const Data({required this.user});
  factory Data.fromJson(json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [user];
}
