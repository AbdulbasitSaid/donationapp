class User {
  User({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
  });

  final String id;
  final String email;
  final bool isActive;
  final DateTime? emailVerifiedAt;
  final Donor donor;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        donor: Donor.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "donor": donor.toJson(),
      };
}

class Donor {
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
}
