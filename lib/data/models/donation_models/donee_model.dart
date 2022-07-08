import 'package:idonatio/data/models/donation_models/country_model.dart';
import 'package:idonatio/data/models/donation_models/organization_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donee_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DoneeModel {
  DoneeModel({
    required this.id,
    required this.doneeCode,
    required this.firstName,
    required this.lastName,
    required this.isOnboarded,
    required this.hasCompletedStripeOnboarding,
    required this.roleId,
    required this.organizationId,
    required this.stripeConnectedAccountId,
    required this.dateOfBirth,
    required this.email,
    required this.isActive,
    required this.hasVerifiedCharity,
    required this.feeRate,
    required this.countryId,
    required this.type,
    required this.jobTitle,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
    required this.verifiedAt,
    required this.createdAt,
    required this.imageUrl,
    required this.country,
    required this.organization,
  });

  final String id;
  final String doneeCode;
  final String firstName;
  final String lastName;
  final bool isOnboarded;
  final bool hasCompletedStripeOnboarding;
  final int roleId;
  final String organizationId;
  final String stripeConnectedAccountId;
  final DateTime dateOfBirth;
  final String email;
  final bool isActive;
  final int hasVerifiedCharity;
  final String feeRate;
  final String countryId;
  final String type;
  final String jobTitle;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String postalCode;
  final String phoneNumber;
  final DateTime verifiedAt;
  final DateTime createdAt;
  final String? imageUrl;
  final CountryModel country;
  final Organization? organization;

  factory DoneeModel.fromJson(json) => _$DoneeModelFromJson(json);

  String get fullAddress => organization == null
      ? "$addressLine1 $addressLine2"
      : "${organization!.addressLine_1}" "${organization!.addressLine_2}";
  String get fullName =>
      organization == null ? "$firstName $lastName" : "${organization?.name}";

  Map<String, dynamic> toJson() => _$DoneeModelToJson(this);
}
