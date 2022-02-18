import 'package:idonatio/data/models/donation_models/donee_country_model.dart';
import 'package:idonatio/data/models/donation_models/donee_organization_model.dart';

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
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? phoneNumber;
  String? verifiedAt;
  DoneeCountry? country;
  DoneeOrganization? organization;

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
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.postalCode,
      this.phoneNumber,
      this.verifiedAt,
      this.country,
      this.organization});

  Donee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doneeCode = json['donee_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    stripeConnectedAccountId = json['stripe_connected_account_id'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    isActive = json['is_active'];
    countryId = json['country_id'];
    type = json['type'];
    jobTitle = json['job_title'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
    verifiedAt = json['verified_at'];
    country =
        json['country'] != null ? DoneeCountry.fromJson(json['country']) : null;
    organization = json['organization'] != null
        ? DoneeOrganization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['donee_code'] = doneeCode;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['stripe_connected_account_id'] = stripeConnectedAccountId;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['is_active'] = isActive;
    data['country_id'] = countryId;
    data['type'] = type;
    data['job_title'] = jobTitle;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['phone_number'] = phoneNumber;
    data['verified_at'] = verifiedAt;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    return data;
  }
}