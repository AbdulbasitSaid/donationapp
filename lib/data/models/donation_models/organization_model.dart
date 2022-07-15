import 'package:json_annotation/json_annotation.dart';

import 'country_model.dart';
part 'organization_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class OrganizationModel {
  OrganizationModel({
    required this.id,
    required this.doneeId,
    required this.countryId,
    required this.state,
    required this.name,
    required this.registrationNumber,
    required this.isSubsidiary,
    this.subsidiaryNumber,
    required this.addressLine_1,
    required this.addressLine_2,
    required this.city,
    required this.postalCode,
    required this.hmrcReferenceNumber,
    required this.phoneNumber,
    required this.email,
    required this.shouldSendEmail,
    this.website,
    this.altName,
    this.altAddressLine_1,
    this.altAddressLine_2,
    this.altCity,
    this.altPostalCode,
    this.altCountryId,
    required this.country,
  });
  late final String? id;
  late final String? doneeId;
  late final String? countryId;
  late final String? state;
  late final String? name;
  late final String? registrationNumber;
  late final bool? isSubsidiary;
  late final String? subsidiaryNumber;
  late final String? addressLine_1;
  late final String? addressLine_2;
  late final String? city;
  late final String? postalCode;
  late final String? hmrcReferenceNumber;
  late final String? phoneNumber;
  late final String? email;
  late final bool? shouldSendEmail;
  late final String? website;
  late final String? altName;
  late final String? altAddressLine_1;
  late final String? altAddressLine_2;
  late final String? altCity;
  late final String? altPostalCode;
  late final String? altCountryId;
  late final CountryModel? country;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);
}
