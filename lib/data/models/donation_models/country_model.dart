import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Country {
  String? id;
  String? name;
  String? countryCode;
  String? currencyCode;
  bool? isVisible;

  Country(
      {this.id,
      this.name,
      this.countryCode,
      this.currencyCode,
      this.isVisible});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
