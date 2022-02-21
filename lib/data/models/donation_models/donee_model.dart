import 'package:idonatio/data/models/donation_models/country_model.dart';
import 'package:idonatio/data/models/donation_models/organization_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'donation_type_model.dart';
part 'donee_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Donee {
  String? id;
  String? doneeCode;
  String? firstName;
  String? lastName;
  String? stripeConnectedAccountId;
  String? dateOfBirth;
  String? email;
  bool? isActive;
  String? countryId;
  String? type;
  String? jobTitle;
  String? addressLine_1;
  String? addressLine_2;
  String? city;
  String? postalCode;
  String? phoneNumber;
  String? verifiedAt;
  Country? country;
  Organization? organization;
  DonationTypeModel? donationTypeModel;
  Donee(
      {this.id,
      this.doneeCode,
      this.firstName,
      this.lastName,
      this.stripeConnectedAccountId,
      this.dateOfBirth,
      this.email,
      this.isActive,
      this.countryId,
      this.type,
      this.jobTitle,
      this.addressLine_1,
      this.addressLine_2,
      this.city,
      this.postalCode,
      this.phoneNumber,
      this.verifiedAt,
      this.country,
      this.organization});

  factory Donee.fromJson(Map<String, dynamic> json) => _$DoneeFromJson(json);

  Map<String, dynamic> toJson() => _$DoneeToJson(this);
}
