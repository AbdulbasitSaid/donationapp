import 'dart:developer';

import '../data/models/fees_model.dart';

final List<String> europeanCountries = [
  'AL',
  'AD',
  'AM',
  'BY',
  'BA',
  'FO',
  'GE',
  'GI',
  'IS',
  'IM',
  'XK',
  'LI',
  'MK',
  'MD',
  'MC',
  'ME',
  'NO',
  'RU',
  'SM',
  'RS',
  'CH',
  'TR',
  'UA',
  'GB',
  'VA',
];
ChargesResult getCharges(
    {required List<FeeData> feeData,
    required String cardCurrency,
    required double amount}) {
  double europeanCardFeePercentage = feeData
      .firstWhere((element) => element.tag == 'STRIPE_EUROPEAN_CARD_FEE')
      .value;
  double nonEuropeanCardFeePercentage = feeData
      .firstWhere((element) => element.tag == 'STRIPE_NON_EUROPEAN_CARD_FEE')
      .value;
  double idonatioFee = getIdonatioTransactionFee(
      donationAmount: amount,
      stripeDontionRatio:
          feeData.firstWhere((element) => element.tag == 'IDONATIO_FEE').value);
  //
  double stripeFixedFee =
      feeData.firstWhere((element) => element.tag == 'STRIPE_FIXED_FEE').value;
  double cardFee = europeanCountries.contains(cardCurrency.toUpperCase())
      ? europeanCardFeePercentage
      : nonEuropeanCardFeePercentage;
  //
  double totalCharge = (amount + idonatioFee + stripeFixedFee) / (1 - cardFee);

  double charges = totalCharge - amount;
  var spliteCharge = charges.toString().split('.');
  log(spliteCharge.toString());
  var left = spliteCharge[0];
  var right = spliteCharge[1].split('');
  String stringCharg = left + '.' + right.elementAt(0) + right.elementAt(1);
  charges = double.parse(stringCharg);
  // onlyCharges.
  return amount == 0
      ? ChargesResult(stripeFee: 0.0, totalFee: 0.0, idonationFee: 0.0)
      : ChargesResult(
          idonationFee: idonatioFee,
          stripeFee: stripeFixedFee,
          totalFee: charges);
}

//
double getIdonatioTransactionFee(
    {required double donationAmount, required double stripeDontionRatio}) {
  return donationAmount == 0 ? 0 : donationAmount * stripeDontionRatio;
}

//
double getStripeTransactionFee({
  required double donationAmount,
  required double cardFee,
  required double fixedStripeFee,
}) {
  return donationAmount == 0 ? 0 : donationAmount * cardFee + fixedStripeFee;
}

class ChargesResult {
  final double stripeFee;
  final double totalFee;
  final double idonationFee;

  ChargesResult(
      {required this.stripeFee,
      required this.totalFee,
      required this.idonationFee});
}
