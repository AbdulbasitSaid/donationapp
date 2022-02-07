import 'dart:convert';

import 'package:flutter/foundation.dart';

class SavedDoneesResponseModel {
  String status;
  String message;
  List<SavedDoneeData> data;
  SavedDoneesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  String toString() =>
      'RecentDonees(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SavedDoneesResponseModel &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory SavedDoneesResponseModel.fromMap(Map<String, dynamic> map) {
    return SavedDoneesResponseModel(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      data: List<SavedDoneeData>.from(
          map['data']?.map((x) => SavedDoneeData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedDoneesResponseModel.fromJson(String source) =>
      SavedDoneesResponseModel.fromMap(json.decode(source));
}

class SavedDoneeData {
  String id;
  String doneeCode;
  String firstName;
  String lastName;
  String stripeConnectedAccountId;
  dynamic dateOfBirth;
  String email;
  bool isActive;
  String countryId;
  String type;
  String jobTitle;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String phoneNumber;
  dynamic verifiedAt;
  Country country;
  Organization? organization;
  SavedDoneeData({
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
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
    required this.verifiedAt,
    required this.country,
    required this.organization,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'donee_code': doneeCode,
      'first_name': firstName,
      'last_name': lastName,
      'stripe_connected_account_id': stripeConnectedAccountId,
      'date_of_birth': dateOfBirth.millisecondsSinceEpoch,
      'email': email,
      'is_active': isActive,
      'country_id': countryId,
      'type': type,
      'job_title': jobTitle,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'city': city,
      'postal_code': postalCode,
      'phone_number': phoneNumber,
      'verified_at': verifiedAt.millisecondsSinceEpoch,
      'country': country.toMap(),
      'organization': organization?.toMap(),
    };
  }

  factory SavedDoneeData.fromMap(Map<String, dynamic> map) {
    return SavedDoneeData(
      id: map['id'] ?? '',
      doneeCode: map['donee_code'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      stripeConnectedAccountId: map['stripe_connected_account_id'] ?? '',
      dateOfBirth: map['date_of_birth'],
      email: map['email'] ?? '',
      isActive: map['is_active'] ?? false,
      countryId: map['country_id'] ?? '',
      type: map['type'] ?? '',
      jobTitle: map['job_title'] ?? '',
      addressLine1: map['address_line_1'] ?? '',
      addressLine2: map['address_line_2'] ?? '',
      city: map['city'] ?? '',
      postalCode: map['postal_code'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      verifiedAt: map['verified_at'],
      country: Country.fromMap(map['country']),
      organization: map['organization'] != null
          ? Organization.fromMap(map['organization'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedDoneeData.fromJson(String source) =>
      SavedDoneeData.fromMap(json.decode(source));
}

class Country {
  String id;
  String name;
  String countryCode;
  String currencyCode;
  bool isVisible;
  Country({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.currencyCode,
    required this.isVisible,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'is_visible': isVisible,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      isVisible: map['is_visible'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));
}

class Organization {
  String? id;
  String? doneeId;
  String? countryId;
  String? state;
  String? name;
  String? registrationNumber;
  bool? isSubsidiary;
  dynamic subsidiaryNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? hmrcReferenceNumber;
  String? phoneNumber;
  String? email;
  bool shouldSendEmail;
  dynamic website;
  dynamic altName;
  dynamic altAddressLine1;
  dynamic altAddressLine2;
  dynamic altCity;
  dynamic altPostalCode;
  dynamic altCountryId;
  Country? country;
  Organization({
    required this.id,
    required this.doneeId,
    required this.countryId,
    required this.state,
    required this.name,
    required this.registrationNumber,
    required this.isSubsidiary,
    required this.subsidiaryNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.hmrcReferenceNumber,
    required this.phoneNumber,
    required this.email,
    required this.shouldSendEmail,
    required this.website,
    required this.altName,
    required this.altAddressLine1,
    required this.altAddressLine2,
    required this.altCity,
    required this.altPostalCode,
    required this.altCountryId,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'donee_id': doneeId,
      'country_id': countryId,
      'state': state,
      'name': name,
      'registration_number': registrationNumber,
      'is_subsidiary': isSubsidiary,
      'subsidiary_number': subsidiaryNumber,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'city': city,
      'postal_code': postalCode,
      'hmrc_reference_number': hmrcReferenceNumber,
      'phone_number': phoneNumber,
      'email': email,
      'should_send_email': shouldSendEmail,
      'website': website,
      'altName': altName,
      'alt_address_line_1': altAddressLine1,
      'alt_address_line_2': altAddressLine2,
      'alt_city': altCity,
      'alt_postal_code': altPostalCode,
      'alt_country_id': altCountryId,
      'country': country?.toMap(),
    };
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'],
      doneeId: map['donee_id'],
      countryId: map['country_id'],
      state: map['state'],
      name: map['name'],
      registrationNumber: map['registration_number'],
      isSubsidiary: map['is_subsidiary'],
      subsidiaryNumber: map['subsidiary_number'],
      addressLine1: map['address_line_1'],
      addressLine2: map['address_line_2'],
      city: map['city'],
      postalCode: map['postal_code'],
      hmrcReferenceNumber: map['hmrc_reference_number'],
      phoneNumber: map['phone_number'],
      email: map['email'],
      shouldSendEmail: map['should_send_email'] ?? false,
      website: map['website'],
      altName: map['altName'],
      altAddressLine1: map['alt_address_line_1'],
      altAddressLine2: map['alt_address_line_2'],
      altCity: map['alt_city'],
      altPostalCode: map['alt_postal_code'],
      altCountryId: map['alt_country_id'],
      country: map['country'] != null ? Country.fromMap(map['country']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Organization.fromJson(String source) =>
      Organization.fromMap(json.decode(source));
}
