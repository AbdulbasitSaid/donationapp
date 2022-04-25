// To parse this JSON data, do
//
//     final makeDonationEntity = makeDonationEntityFromMap(jsonString);

import 'dart:convert';

class MakeDonationEntity {
  MakeDonationEntity({
    required this.doneeId,
    required this.channel,
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
    required this.idonatioTransactionFee,
    required this.stripTransactionFee,
    required this.totalFee,
  });

  final String doneeId;
  final bool paidTransactionFee;
  final String donationMethod;
  final String channel;
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
  final List<DonationDetail> donationDetails;
  final double amount;
  final String stripeConnectedAccountId;
  final String stripePaymentMethodId;
  final double idonatioTransactionFee;
  final double stripTransactionFee;
  final double totalFee;

  factory MakeDonationEntity.fromJson(String str) =>
      MakeDonationEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MakeDonationEntity.fromMap(Map<dynamic, dynamic> json) =>
      MakeDonationEntity(
        idonatioTransactionFee: json['idonatio_transaction_fee'],
        channel: json["channel"],
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
        donationDetails: List<DonationDetail>.from(
            json["donation_details"].map((x) => DonationDetail.fromMap(x))),
        amount: json["amount"],
        stripeConnectedAccountId: json["stripe_connected_account_id"],
        stripePaymentMethodId: json["stripe_payment_method_id"],
        stripTransactionFee: json['stripe_transaction_fee'],
        totalFee: json['total_fee'],
      );

  Map<dynamic, dynamic> toMap() => {
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
        "donation_details":
            List<dynamic>.from(donationDetails.map((x) => x.toMap())),
        "amount": amount,
        "chaneel": channel,
        "stripe_connected_account_id": stripeConnectedAccountId,
        "stripe_payment_method_id": stripePaymentMethodId,
        "idonatio_transaction_fee": idonatioTransactionFee,
        "stripe_transaction_fee": stripTransactionFee,
        "total_fee": totalFee,
      };
}

class DonationDetail {
  DonationDetail({
    required this.donationTypeId,
    required this.amount,
  });

  final String donationTypeId;
  final double amount;

  factory DonationDetail.fromJson(String str) =>
      DonationDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DonationDetail.fromMap(Map<dynamic, dynamic> json) => DonationDetail(
        donationTypeId: json["donation_type_id"],
        amount: json["amount"],
      );

  Map<dynamic, dynamic> toMap() => {
        "donation_type_id": donationTypeId,
        "amount": amount,
      };
}
