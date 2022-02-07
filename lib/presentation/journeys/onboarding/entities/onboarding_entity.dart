// To parse this JSON data, do
//
//     final onboardingEntity = onboardingEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

OnboardingEntity onboardingEntityFromJson(String str) =>
    OnboardingEntity.fromJson(json.decode(str));

String onboardingEntityToJson(OnboardingEntity data) =>
    json.encode(data.toJson());

class OnboardingEntity extends Equatable {
  const OnboardingEntity({
    this.giftAidEnabled = false,
    this.address = '',
    this.city = '',
    this.county = '',
    this.postalCode = '',
    this.countryId = '',
    this.paymentMethod,
    this.stripeCustomerId,
    this.sendMarketingMail = false,
    this.isOnboarded = false,
    this.donateAnonymously = false,
  });

  final  bool giftAidEnabled;
  final String address;
  final String city;
  final String county;
  final String postalCode;
  final String countryId;
  final String? stripeCustomerId;
  final String? paymentMethod;
  final bool sendMarketingMail;
  final bool isOnboarded;
  final bool donateAnonymously;

  factory OnboardingEntity.fromJson(Map<String, dynamic> json) =>
      OnboardingEntity(
          giftAidEnabled: json["gift_aid_enabled"],
          address: json["address"],
          city: json["city"],
          county: json["county"],
          postalCode: json["postal_code"],
          countryId: json["country_id"],
          paymentMethod: json["payment_method"],
          sendMarketingMail: json["send_marketing_mail"],
          isOnboarded: json["is_onboarded"],
          donateAnonymously: json['donate_anonymously'],
          stripeCustomerId: json['stripe_customer_id']);

  Map<String, dynamic> toJson() => {
        "gift_aid_enabled": giftAidEnabled,
        "address": address,
        "city": city,
        "county": county,
        "postal_code": postalCode,
        "country_id": countryId,
        "payment_method": paymentMethod,
        "send_marketing_mail": sendMarketingMail,
        "is_onboarded": isOnboarded,
        "stripe_customer_id": stripeCustomerId,
        'donate_anonymously': donateAnonymously,
      };

  @override
  List<Object?> get props => [
        {'giftAidEnabled': giftAidEnabled},
        {'address ': address},
        {'city ': city},
        {'country id ': countryId},
        {'county ': county},
        {'postal code ': postalCode},
        {'payment method ': paymentMethod},
        {'send marketing mail ': sendMarketingMail},
        {'is onboarding ': isOnboarded},
        {'donate anonymously ?': donateAnonymously},
        {'stripe customer id': stripeCustomerId}
      ];
}
