import 'package:idonatio/data/models/donation_models/donation_details.dart';
import 'package:json_annotation/json_annotation.dart';

import 'country_model.dart';
import 'donation_type_model.dart';
import 'organization_model.dart';
part 'donee_response_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DoneeResponseModel {
  DoneeResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final Data data;

  factory DoneeResponseModel.fromJson(json) =>
      _$DoneeResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoneeResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Data {
  Data({
    required this.id,
    required this.doneeCode,
    required this.firstName,
    required this.lastName,
    required this.stripeConnectedAccountId,
    required this.dateOfBirth,
    required this.email,
    required this.isActive,
    required this.countryId,
    required this.type,
    required this.jobTitle,
    required this.addressLine_1,
    required this.addressLine_2,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
    required this.verifiedAt,
    required this.country,
    required this.organization,
    required this.donationTypes,
  });
  late final String id;
  late final String doneeCode;
  late final String firstName;
  late final String lastName;
  late final String stripeConnectedAccountId;
  late final String dateOfBirth;
  late final String email;
  late final bool isActive;
  late final String countryId;
  late final String type;
  late final String jobTitle;
  late final String addressLine_1;
  late final String addressLine_2;
  late final String city;
  late final String postalCode;
  late final String phoneNumber;
  late final String verifiedAt;
  late final Country country;
  late final Organization? organization;
  late final List<DonationDetails>? donationDetails;
  late final List<DonationTypeModel>? donationTypes;
  String get fullName {
    return organization == null
        ? "$firstName $lastName"
        : "${organization!.name}";
  }

  bool get isSingleDonationType {
    return donationTypes!.length < 2;
  }

  String get fullAddress {
    return organization == null
        ? addressLine_1 + addressLine_2
        : "${organization?.addressLine_1} + ${organization?.addressLine_2}";
  }

  String get website {
    return organization == null ? 'has no website' : '${organization?.website}';
  }

  String get currency {
    return organization == null
        ? country.currencyCode!
        : organization!.country!.currencyCode!;
  }

  factory Data.fromJson(json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
