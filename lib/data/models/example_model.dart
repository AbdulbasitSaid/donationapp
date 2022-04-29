import 'package:json_annotation/json_annotation.dart';
part 'example_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Example {
  Example({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  DoneeData data;
  factory Example.fromJson(json) => _$ExampleFromJson(json);
}

/// this is in  another file
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DoneeData {
  DoneeData({
    required this.id,
    required this.doneeCode,
    required this.firstName,
    required this.lastName,
    required this.isOnboarded,
    required this.roleId,
    required this.organizationId,
    required this.stripeConnectedAccountId,
    required this.dateOfBirth,
    required this.email,
    required this.isActive,
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
    required this.donationTypes,
  });

  String id;
  String doneeCode;
  String firstName;
  String lastName;
  bool isOnboarded;
  int roleId;
  String organizationId;
  String stripeConnectedAccountId;
  DateTime dateOfBirth;
  String email;
  bool isActive;
  String feeRate;
  String countryId;
  String type;
  String jobTitle;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String phoneNumber;
  DateTime verifiedAt;
  DateTime createdAt;
  List<DonationType> donationTypes;
  factory DoneeData.fromJson(json) => _$DoneeDataFromJson(json);
}

// this is is another folder
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationType {
  DonationType({
    required this.id,
    required this.doneeId,
    required this.type,
    required this.description,
    required this.giftAidEligible,
    required this.isActive,
    required this.createdAt,
  });

  String id;
  String doneeId;
  String type;
  String description;
  bool giftAidEligible;
  bool isActive;
  DateTime createdAt;
}
