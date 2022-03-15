import 'package:hive/hive.dart';

part 'donor_model.g.dart';

@HiveType(typeId: 0)
class DonorModel {
  @HiveField(0)
  final String id;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final bool isOnboarded;
  @HiveField(5)
  final String title;
  @HiveField(6)
  final String? phoneNumber;
  @HiveField(7)
  final dynamic phoneVerifiedAt;
  @HiveField(8)
  final bool phoneReceiveSecurityAlert;
  @HiveField(9)
  final bool giftAidEnabled;
  @HiveField(10)
  final dynamic address;
  @HiveField(11)
  final dynamic city;
  @HiveField(12)
  final dynamic countryId;
  @HiveField(13)
  final dynamic postalCode;
  @HiveField(14)
  final dynamic paymentMethod;
  @HiveField(15)
  final String? stripeCustomerId;
  @HiveField(16)
  final bool sendMarketingMail;

  DonorModel({
    required this.id,
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

  factory DonorModel.fromJson(Map<String, dynamic> json) => DonorModel(
      id: json["id"],
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

    return other is DonorModel &&
        other.id == id &&
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

  @override
  String toString() {
    return 'DonorModel(id: $id,  firstName: $firstName, lastName: $lastName, isOnboarded: $isOnboarded, title: $title, phoneNumber: $phoneNumber, phoneVerifiedAt: $phoneVerifiedAt, phoneReceiveSecurityAlert: $phoneReceiveSecurityAlert, giftAidEnabled: $giftAidEnabled, address: $address, city: $city, countryId: $countryId, postalCode: $postalCode, paymentMethod: $paymentMethod, stripeCustomerId: $stripeCustomerId, sendMarketingMail: $sendMarketingMail)';
  }

  DonorModel copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    bool? isOnboarded,
    String? title,
    String? phoneNumber,
    dynamic phoneVerifiedAt,
    bool? phoneReceiveSecurityAlert,
    bool? giftAidEnabled,
    dynamic address,
    dynamic countryId,
    dynamic postalCode,
    dynamic paymentMethod,
    String? stripeCustomerId,
    bool? sendMarketingMail,
  }) {
    return DonorModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      title: title ?? this.title,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      phoneReceiveSecurityAlert:
          phoneReceiveSecurityAlert ?? this.phoneReceiveSecurityAlert,
      giftAidEnabled: giftAidEnabled ?? this.giftAidEnabled,
      address: address ?? this.address,
      city: city ?? city,
      countryId: countryId ?? this.countryId,
      postalCode: postalCode ?? this.postalCode,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      sendMarketingMail: sendMarketingMail ?? this.sendMarketingMail,
    );
  }
}
