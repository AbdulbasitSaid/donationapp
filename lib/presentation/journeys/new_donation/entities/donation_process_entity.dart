// To parse this JSON data, do
//
//     final donationProcessEntity = donationProcessEntityFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

class DonationProcessEntity {
  DonationProcessEntity({
    required this.doneeId,
    required this.paidTransactionFee,
    required this.donationMethod,
    required this.donationLocation,
    required this.isAnonymous,
    required this.applyGiftAidToDonation,
    required this.giftAidEnabled,
    required this.currency,
    required this.cardLastFourDigits,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
    required this.saveDonee,
    required this.donationDetails,
    required this.amount,
    required this.stripeConnectedAccountId,
    required this.stripePaymentMethodId,
    required this.idonatoiFee,
    required this.stripeFee,
  });

  final String doneeId;
  final bool paidTransactionFee;
  final String donationMethod;
  final String donationLocation;
  final bool isAnonymous;
  final bool applyGiftAidToDonation;
  final bool giftAidEnabled;
  final String currency;
  final String cardLastFourDigits;
  final String cardType;
  final int expiryMonth;
  final int expiryYear;
  final bool saveDonee;
  final double idonatoiFee;
  final double stripeFee;
  final List<DonationProcessDetail> donationDetails;
  final int amount;
  final String stripeConnectedAccountId;
  final String stripePaymentMethodId;

  factory DonationProcessEntity.fromJson(String str) =>
      DonationProcessEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DonationProcessEntity.fromMap(Map<String, dynamic> json) =>
      DonationProcessEntity(
        doneeId: json["donee_id"],
        paidTransactionFee: json["paid_transaction_fee"],
        donationMethod: json["donation_method"],
        donationLocation: json["donation_location"],
        isAnonymous: json["is_anonymous"],
        applyGiftAidToDonation: json["apply_gift_aid_to_donation"],
        giftAidEnabled: json["gift_aid_enabled"],
        currency: json["currency"],
        cardLastFourDigits: json["card_last_four_digits"],
        cardType: json["card_type"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        saveDonee: json["save_donee"],
        donationDetails: List<DonationProcessDetail>.from(
            json["donation_details"].map((x) => DonationProcessDetail.fromMap(x))),
        amount: json["amount"],
        stripeConnectedAccountId: json["stripe_connected_account_id"],
        stripePaymentMethodId: json["stripe_payment_method_id"],
        idonatoiFee: json["idonatio_transaction_fee"],
        stripeFee: json["stripe_transaction_fee"],
      );

  Map<String, dynamic> toMap() => {
        "donee_id": doneeId,
        "paid_transaction_fee": paidTransactionFee,
        "donation_method": donationMethod,
        "donation_location": donationLocation,
        "is_anonymous": isAnonymous,
        "apply_gift_aid_to_donation": applyGiftAidToDonation,
        "gift_aid_enabled": giftAidEnabled,
        "currency": currency,
        "card_last_four_digits": cardLastFourDigits,
        "card_type": cardType,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "save_donee": saveDonee,
        "idonatio_transaction_fee": idonatoiFee,
        "stripe_transaction_fee": stripeFee,
        "donation_details":
            List<dynamic>.from(donationDetails.map((x) => x.toMap())),
        "amount": amount,
        "stripe_connected_account_id": stripeConnectedAccountId,
        "stripe_payment_method_id": stripePaymentMethodId,
      };

  @override
  String toString() {
    return 'DonationProcessEntity(doneeId: $doneeId, paidTransactionFee: $paidTransactionFee, donationMethod: $donationMethod, donationLocation: $donationLocation, isAnonymous: $isAnonymous, applyGiftAidToDonation: $applyGiftAidToDonation, giftAidEnabled: $giftAidEnabled, currency: $currency, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, expiryMonth: $expiryMonth, expiryYear: $expiryYear, saveDonee: $saveDonee, idonatoiFee: $idonatoiFee, stripeFee: $stripeFee, donationDetails: $donationDetails, amount: $amount, stripeConnectedAccountId: $stripeConnectedAccountId, stripePaymentMethodId: $stripePaymentMethodId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DonationProcessEntity &&
      other.doneeId == doneeId &&
      other.paidTransactionFee == paidTransactionFee &&
      other.donationMethod == donationMethod &&
      other.donationLocation == donationLocation &&
      other.isAnonymous == isAnonymous &&
      other.applyGiftAidToDonation == applyGiftAidToDonation &&
      other.giftAidEnabled == giftAidEnabled &&
      other.currency == currency &&
      other.cardLastFourDigits == cardLastFourDigits &&
      other.cardType == cardType &&
      other.expiryMonth == expiryMonth &&
      other.expiryYear == expiryYear &&
      other.saveDonee == saveDonee &&
      other.idonatoiFee == idonatoiFee &&
      other.stripeFee == stripeFee &&
      listEquals(other.donationDetails, donationDetails) &&
      other.amount == amount &&
      other.stripeConnectedAccountId == stripeConnectedAccountId &&
      other.stripePaymentMethodId == stripePaymentMethodId;
  }

  @override
  int get hashCode {
    return doneeId.hashCode ^
      paidTransactionFee.hashCode ^
      donationMethod.hashCode ^
      donationLocation.hashCode ^
      isAnonymous.hashCode ^
      applyGiftAidToDonation.hashCode ^
      giftAidEnabled.hashCode ^
      currency.hashCode ^
      cardLastFourDigits.hashCode ^
      cardType.hashCode ^
      expiryMonth.hashCode ^
      expiryYear.hashCode ^
      saveDonee.hashCode ^
      idonatoiFee.hashCode ^
      stripeFee.hashCode ^
      donationDetails.hashCode ^
      amount.hashCode ^
      stripeConnectedAccountId.hashCode ^
      stripePaymentMethodId.hashCode;
  }

  DonationProcessEntity copyWith({
    String? doneeId,
    bool? paidTransactionFee,
    String? donationMethod,
    String? donationLocation,
    bool? isAnonymous,
    bool? applyGiftAidToDonation,
    bool? giftAidEnabled,
    String? currency,
    String? cardLastFourDigits,
    String? cardType,
    int? expiryMonth,
    int? expiryYear,
    bool? saveDonee,
    double? idonatoiFee,
    double? stripeFee,
    List<DonationProcessDetail>? donationDetails,
    int? amount,
    String? stripeConnectedAccountId,
    String? stripePaymentMethodId,
  }) {
    return DonationProcessEntity(
      doneeId: doneeId ?? this.doneeId,
      paidTransactionFee: paidTransactionFee ?? this.paidTransactionFee,
      donationMethod: donationMethod ?? this.donationMethod,
      donationLocation: donationLocation ?? this.donationLocation,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      applyGiftAidToDonation: applyGiftAidToDonation ?? this.applyGiftAidToDonation,
      giftAidEnabled: giftAidEnabled ?? this.giftAidEnabled,
      currency: currency ?? this.currency,
      cardLastFourDigits: cardLastFourDigits ?? this.cardLastFourDigits,
      cardType: cardType ?? this.cardType,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      saveDonee: saveDonee ?? this.saveDonee,
      idonatoiFee: idonatoiFee ?? this.idonatoiFee,
      stripeFee: stripeFee ?? this.stripeFee,
      donationDetails: donationDetails ?? this.donationDetails,
      amount: amount ?? this.amount,
      stripeConnectedAccountId: stripeConnectedAccountId ?? this.stripeConnectedAccountId,
      stripePaymentMethodId: stripePaymentMethodId ?? this.stripePaymentMethodId,
    );
  }
}

class DonationProcessDetail {
  DonationProcessDetail({
    required this.donationTypeId,
    required this.amount,
  });

  final String donationTypeId;
  final int amount;

  factory DonationProcessDetail.fromJson(String str) =>
      DonationProcessDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DonationProcessDetail.fromMap(Map<String, dynamic> json) => DonationProcessDetail(
        donationTypeId: json["donation_type_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "donation_type_id": donationTypeId,
        "amount": amount,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationProcessDetail &&
        other.donationTypeId == donationTypeId &&
        other.amount == amount;
  }

  @override
  int get hashCode => donationTypeId.hashCode ^ amount.hashCode;
}
