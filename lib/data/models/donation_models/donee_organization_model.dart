import 'donee_country_model.dart';

class DoneeOrganization {
  String? id;
  String? doneeId;
  String? countryId;
  String? state;
  String? name;
  String? registrationNumber;
  bool? isSubsidiary;
  String? subsidiaryNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? hmrcReferenceNumber;
  String? phoneNumber;
  String? email;
  bool? shouldSendEmail;
  String? website;
  String? altName;
  String? altAddressLine1;
  String? altAddressLine2;
  String? altCity;
  String? altPostalCode;
  String? altCountryId;
  DoneeCountry? country;
  String? alternativeCountry;

  DoneeOrganization(
      {this.id,
      this.doneeId,
      this.countryId,
      this.state,
      this.name,
      this.registrationNumber,
      this.isSubsidiary,
      this.subsidiaryNumber,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.postalCode,
      this.hmrcReferenceNumber,
      this.phoneNumber,
      this.email,
      this.shouldSendEmail,
      this.website,
      this.altName,
      this.altAddressLine1,
      this.altAddressLine2,
      this.altCity,
      this.altPostalCode,
      this.altCountryId,
      this.country,
      this.alternativeCountry});

  DoneeOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doneeId = json['donee_id'];
    countryId = json['country_id'];
    state = json['state'];
    name = json['name'];
    registrationNumber = json['registration_number'];
    isSubsidiary = json['is_subsidiary'];
    subsidiaryNumber = json['subsidiary_number'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'];
    postalCode = json['postal_code'];
    hmrcReferenceNumber = json['hmrc_reference_number'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    shouldSendEmail = json['should_send_email'];
    website = json['website'];
    altName = json['alt_name'];
    altAddressLine1 = json['alt_address_line_1'];
    altAddressLine2 = json['alt_address_line_2'];
    altCity = json['alt_city'];
    altPostalCode = json['alt_postal_code'];
    altCountryId = json['alt_country_id'];
    country =
        json['country'] != null ? DoneeCountry.fromJson(json['country']) : null;
    alternativeCountry = json['alternative_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['donee_id'] = doneeId;
    data['country_id'] = countryId;
    data['state'] = state;
    data['name'] = name;
    data['registration_number'] = registrationNumber;
    data['is_subsidiary'] = isSubsidiary;
    data['subsidiary_number'] = subsidiaryNumber;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['hmrc_reference_number'] = hmrcReferenceNumber;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['should_send_email'] = shouldSendEmail;
    data['website'] = website;
    data['alt_name'] = altName;
    data['alt_address_line_1'] = altAddressLine1;
    data['alt_address_line_2'] = altAddressLine2;
    data['alt_city'] = altCity;
    data['alt_postal_code'] = altPostalCode;
    data['alt_country_id'] = altCountryId;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['alternative_country'] = alternativeCountry;
    return data;
  }
}