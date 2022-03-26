// To parse this JSON data, do
//
//     final donationProcessEntity = donationProcessEntityFromMap(jsonString);

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:idonatio/common/stripe_charges_calculations.dart';
import 'package:idonatio/data/models/fees_model.dart';

part 'donation_process_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DonationProcessEntity {
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
  final double amount;
  final String stripeConnectedAccountId;
  final String stripePaymentMethodId;
  final double totalCharges;
  final String cardCountry;
  final double cartAmount;
  final List<FeeData> feedata;
  DonationProcessEntity(
      {required this.doneeId,
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
      required this.totalCharges,
      required this.cardCountry,
      required this.feedata,
      required this.cartAmount});
  double get getTotalCharges {
    return getCharges(
            feeData: feedata, cardCurrency: cardCountry, amount: cartAmount)
        .totalFee;
  }

  double get getIdonationFee {
    return getCharges(
            feeData: feedata, cardCurrency: cardCountry, amount: cartAmount)
        .idonationFee;
  }

  double get getStripeFee {
    return getCharges(
            feeData: feedata, cardCurrency: cardCountry, amount: cartAmount)
        .stripeFee;
  }

  factory DonationProcessEntity.fromJson(json) =>
      _$DonationProcessEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DonationProcessEntityToJson(this);
  @override
  String toString() {
    return 'DonationProcessEntity(doneeId: $doneeId, paidTransactionFee: $paidTransactionFee, donationMethod: $donationMethod, donationLocation: $donationLocation, isAnonymous: $isAnonymous, applyGiftAidToDonation: $applyGiftAidToDonation, giftAidEnabled: $giftAidEnabled, currency: $currency, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, expiryMonth: $expiryMonth, expiryYear: $expiryYear, saveDonee: $saveDonee, idonatoiFee: $idonatoiFee, stripeFee: $stripeFee, donationDetails: $donationDetails, amount: $amount, stripeConnectedAccountId: $stripeConnectedAccountId, stripePaymentMethodId: $stripePaymentMethodId, totalCharges: $totalCharges, cardCountry: $cardCountry, cartAmount: $cartAmount, feedata: $feedata)';
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
        other.stripePaymentMethodId == stripePaymentMethodId &&
        other.totalCharges == totalCharges &&
        other.cardCountry == cardCountry &&
        other.cartAmount == cartAmount &&
        listEquals(other.feedata, feedata);
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
        stripePaymentMethodId.hashCode ^
        totalCharges.hashCode ^
        cardCountry.hashCode ^
        cartAmount.hashCode ^
        feedata.hashCode;
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
    double? amount,
    String? stripeConnectedAccountId,
    String? stripePaymentMethodId,
    double? totalCharges,
    String? cardCountry,
    double? cartAmount,
    List<FeeData>? feedata,
  }) {
    return DonationProcessEntity(
      doneeId: doneeId ?? this.doneeId,
      paidTransactionFee: paidTransactionFee ?? this.paidTransactionFee,
      donationMethod: donationMethod ?? this.donationMethod,
      donationLocation: donationLocation ?? this.donationLocation,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      applyGiftAidToDonation:
          applyGiftAidToDonation ?? this.applyGiftAidToDonation,
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
      stripeConnectedAccountId:
          stripeConnectedAccountId ?? this.stripeConnectedAccountId,
      stripePaymentMethodId:
          stripePaymentMethodId ?? this.stripePaymentMethodId,
      totalCharges: totalCharges ?? this.totalCharges,
      cardCountry: cardCountry ?? this.cardCountry,
      cartAmount: cartAmount ?? this.cartAmount,
      feedata: feedata ?? this.feedata,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DonationProcessDetail {
  DonationProcessDetail({
    required this.donationTypeId,
    required this.amount,
  });

  final String donationTypeId;
  final double amount;
  factory DonationProcessDetail.fromJson(json) =>
      _$DonationProcessDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DonationProcessDetailToJson(this);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationProcessDetail &&
        other.donationTypeId == donationTypeId &&
        other.amount == amount;
  }

  @override
  int get hashCode => donationTypeId.hashCode ^ amount.hashCode;

  @override
  String toString() =>
      'DonationProcessDetail(donationTypeId: $donationTypeId, amount: $amount)';
}
