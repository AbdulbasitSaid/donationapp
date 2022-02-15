class DonationHistoryModel {
  String? status;
  String? message;
  List<Data>? data;

  DonationHistoryModel({this.status, this.message, this.data});

  DonationHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? donorId;
  String? doneeId;
  bool? paidTransactionFee;
  int? idonatioTransactionFee;
  int? stripeTransactionFee;
  String? donationMethod;
  String? disputeStatus;
  String? donationLocation;
  String? currency;
  bool? isAnonymous;
  bool? applyGiftAidToDonation;
  bool? isPlateDonation;
  String? stripePaymentMethodId;
  String? cardLastFourDigits;
  String? cardType;
  String? expiryMonth;
  String? expiryYear;
  String? createdAt;
  Donee? donee;

  Data(
      {this.id,
      this.donorId,
      this.doneeId,
      this.paidTransactionFee,
      this.idonatioTransactionFee,
      this.stripeTransactionFee,
      this.donationMethod,
      this.disputeStatus,
      this.donationLocation,
      this.currency,
      this.isAnonymous,
      this.applyGiftAidToDonation,
      this.isPlateDonation,
      this.stripePaymentMethodId,
      this.cardLastFourDigits,
      this.cardType,
      this.expiryMonth,
      this.expiryYear,
      this.createdAt,
      this.donee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donorId = json['donor_id'];
    doneeId = json['donee_id'];
    paidTransactionFee = json['paid_transaction_fee'];
    idonatioTransactionFee = json['idonatio_transaction_fee'];
    stripeTransactionFee = json['stripe_transaction_fee'];
    donationMethod = json['donation_method'];
    disputeStatus = json['dispute_status'];
    donationLocation = json['donation_location'];
    currency = json['currency'];
    isAnonymous = json['is_anonymous'];
    applyGiftAidToDonation = json['apply_gift_aid_to_donation'];
    isPlateDonation = json['is_plate_donation'];
    stripePaymentMethodId = json['stripe_payment_method_id'];
    cardLastFourDigits = json['card_last_four_digits'];
    cardType = json['card_type'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    createdAt = json['created_at'];
    donee = json['donee'] != null ? Donee.fromJson(json['donee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['donor_id'] = donorId;
    data['donee_id'] = doneeId;
    data['paid_transaction_fee'] = paidTransactionFee;
    data['idonatio_transaction_fee'] = idonatioTransactionFee;
    data['stripe_transaction_fee'] = stripeTransactionFee;
    data['donation_method'] = donationMethod;
    data['dispute_status'] = disputeStatus;
    data['donation_location'] = donationLocation;
    data['currency'] = currency;
    data['is_anonymous'] = isAnonymous;
    data['apply_gift_aid_to_donation'] = applyGiftAidToDonation;
    data['is_plate_donation'] = isPlateDonation;
    data['stripe_payment_method_id'] = stripePaymentMethodId;
    data['card_last_four_digits'] = cardLastFourDigits;
    data['card_type'] = cardType;
    data['expiry_month'] = expiryMonth;
    data['expiry_year'] = expiryYear;
    data['created_at'] = createdAt;
    if (donee != null) {
      data['donee'] = donee!.toJson();
    }
    return data;
  }
}

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
  Country? country;
  Organization? organization;

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
        json['country'] != null ? Country.fromJson(json['country']) : null;
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
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

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['currency_code'] = currencyCode;
    data['is_visible'] = isVisible;
    return data;
  }
}

class Organization {
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
  Country? country;
  String? alternativeCountry;

  Organization(
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

  Organization.fromJson(Map<String, dynamic> json) {
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
        json['country'] != null ? Country.fromJson(json['country']) : null;
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
