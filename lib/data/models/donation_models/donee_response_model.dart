class DoneeResponseModel {
  DoneeResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final DoneeResponseData data;

  DoneeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DoneeResponseData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class DoneeResponseData {
  DoneeResponseData({
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
  late final List<DonationTypes> donationTypes;

  DoneeResponseData.fromJson(Map<String, dynamic> json) {
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
    addressLine_1 = json['address_line_1'];
    addressLine_2 = json['address_line_2'];
    city = json['city'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
    verifiedAt = json['verified_at'];
    country = Country.fromJson(json['country']);
    organization = Organization?.fromJson(json['organization'] ?? {});
    donationTypes = List.from(json['donation_types'])
        .map((e) => DonationTypes.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['donee_code'] = doneeCode;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['stripe_connected_account_id'] = stripeConnectedAccountId;
    _data['date_of_birth'] = dateOfBirth;
    _data['email'] = email;
    _data['is_active'] = isActive;
    _data['country_id'] = countryId;
    _data['type'] = type;
    _data['job_title'] = jobTitle;
    _data['address_line_1'] = addressLine_1;
    _data['address_line_2'] = addressLine_2;
    _data['city'] = city;
    _data['postal_code'] = postalCode;
    _data['phone_number'] = phoneNumber;
    _data['verified_at'] = verifiedAt;
    _data['country'] = country.toJson();
    _data['organization'] = organization?.toJson();
    _data['donation_types'] = donationTypes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.currencyCode,
    required this.isVisible,
  });
  late final String? id;
  late final String? name;
  late final String? countryCode;
  late final String? currencyCode;
  late final bool? isVisible;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['country_code'] = countryCode;
    _data['currency_code'] = currencyCode;
    _data['is_visible'] = isVisible;
    return _data;
  }
}

class Organization {
  Organization({
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
  late final Country? country;

  Organization.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    doneeId = json['donee_id'];
    countryId = json['country_id'];
    state = json['state'];
    name = json['name'];
    registrationNumber = json['registration_number'];
    isSubsidiary = json['is_subsidiary'];
    subsidiaryNumber = null;
    addressLine_1 = json['address_line_1'];
    addressLine_2 = json['address_line_2'];
    city = json['city'];
    postalCode = json['postal_code'];
    hmrcReferenceNumber = json['hmrc_reference_number'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    shouldSendEmail = json['should_send_email'];
    website = null;
    altName = null;
    altAddressLine_1 = null;
    altAddressLine_2 = null;
    altCity = null;
    altPostalCode = null;
    altCountryId = null;
    country = Country?.fromJson(json['country'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['donee_id'] = doneeId;
    _data['country_id'] = countryId;
    _data['state'] = state;
    _data['name'] = name;
    _data['registration_number'] = registrationNumber;
    _data['is_subsidiary'] = isSubsidiary;
    _data['subsidiary_number'] = subsidiaryNumber;
    _data['address_line_1'] = addressLine_1;
    _data['address_line_2'] = addressLine_2;
    _data['city'] = city;
    _data['postal_code'] = postalCode;
    _data['hmrc_reference_number'] = hmrcReferenceNumber;
    _data['phone_number'] = phoneNumber;
    _data['email'] = email;
    _data['should_send_email'] = shouldSendEmail;
    _data['website'] = website;
    _data['alt_name'] = altName;
    _data['alt_address_line_1'] = altAddressLine_1;
    _data['alt_address_line_2'] = altAddressLine_2;
    _data['alt_city'] = altCity;
    _data['alt_postal_code'] = altPostalCode;
    _data['alt_country_id'] = altCountryId;
    _data['country'] = country?.toJson();
    return _data;
  }
}

class DonationTypes {
  DonationTypes({
    required this.id,
    required this.doneeId,
    required this.type,
    required this.description,
    required this.giftAidEligible,
    required this.isActive,
  });
  late final String id;
  late final String doneeId;
  late final String type;
  late final String description;
  late final bool giftAidEligible;
  late final bool isActive;

  DonationTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doneeId = json['donee_id'];
    type = json['type'];
    description = json['description'];
    giftAidEligible = json['gift_aid_eligible'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['donee_id'] = doneeId;
    _data['type'] = type;
    _data['description'] = description;
    _data['gift_aid_eligible'] = giftAidEligible;
    _data['is_active'] = isActive;
    return _data;
  }
}
