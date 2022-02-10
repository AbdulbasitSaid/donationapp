class Donor {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final bool isOnboarded;
  final String title;
  final String? phoneNumber;
  final dynamic phoneVerifiedAt;
  final bool phoneReceiveSecurityAlert;
  final bool giftAidEnabled;
  final dynamic address;
  final dynamic city;
  final dynamic countryId;
  final dynamic postalCode;
  final dynamic paymentMethod;
  final String? stripeCustomerId;
  final bool sendMarketingMail;
  Donor({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.isOnboarded,
    required this.title,
    required this.phoneNumber,
    required this.phoneVerifiedAt,
    required this.phoneReceiveSecurityAlert,
    required this.giftAidEnabled,
    required this.address,
    required this.city,
    required this.countryId,
    required this.postalCode,
    required this.paymentMethod,
    required this.sendMarketingMail,
    required this.stripeCustomerId,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
      id: json["id"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      isOnboarded: json["is_onboarded"],
      title: json["title"],
      phoneNumber: json["phone_number"],
      phoneVerifiedAt: json["phone_verified_at"],
      phoneReceiveSecurityAlert: json["phone_receive_security_alert"],
      giftAidEnabled: json["gift_aid_enabled"],
      address: json["address"],
      city: json["city"],
      countryId: json["country_id"],
      postalCode: json["postal_code"],
      paymentMethod: json["payment_method"],
      sendMarketingMail: json["send_marketing_mail"],
      stripeCustomerId: json["stripe_customer_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "is_onboarded": isOnboarded,
        "title": title,
        "phone_number": phoneNumber,
        "phone_verified_at": phoneVerifiedAt,
        "phone_receive_security_alert": phoneReceiveSecurityAlert,
        "gift_aid_enabled": giftAidEnabled,
        "address": address,
        "city": city,
        "country_id": countryId,
        "postal_code": postalCode,
        "payment_method": paymentMethod,
        "send_marketing_mail": sendMarketingMail,
        "stripe_customer_id": stripeCustomerId,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Donor &&
        other.id == id &&
        other.userId == userId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.isOnboarded == isOnboarded &&
        other.title == title &&
        other.phoneNumber == phoneNumber &&
        other.phoneVerifiedAt == phoneVerifiedAt &&
        other.phoneReceiveSecurityAlert == phoneReceiveSecurityAlert &&
        other.giftAidEnabled == giftAidEnabled &&
        other.address == address &&
        other.city == city &&
        other.countryId == countryId &&
        other.postalCode == postalCode &&
        other.paymentMethod == paymentMethod &&
        other.stripeCustomerId == stripeCustomerId &&
        other.sendMarketingMail == sendMarketingMail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        isOnboarded.hashCode ^
        title.hashCode ^
        phoneNumber.hashCode ^
        phoneVerifiedAt.hashCode ^
        phoneReceiveSecurityAlert.hashCode ^
        giftAidEnabled.hashCode ^
        address.hashCode ^
        city.hashCode ^
        countryId.hashCode ^
        postalCode.hashCode ^
        paymentMethod.hashCode ^
        stripeCustomerId.hashCode ^
        sendMarketingMail.hashCode;
  }
}
