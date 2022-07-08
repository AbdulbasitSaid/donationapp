import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CountryModel {
  String? id;
  String? name;
  String? countryCode;
  String? currencyCode;
  bool? isVisible;

  CountryModel(
      {this.id,
      this.name,
      this.countryCode,
      this.currencyCode,
      this.isVisible});

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
