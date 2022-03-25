import 'dart:developer';

import '../data/models/fees_model.dart';

double getCharges(
    {required List<FeeData> feeData,
    required String cardCurrency,
    required double amount}) {
  List<String> europeanCountries = [
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

  double europeanCardFeePercentage = feeData
      .firstWhere((element) => element.tag == 'STRIPE_EUROPEAN_CARD_FEE')
      .value;
  double nonEuropeanCardFeePercentage = feeData
      .firstWhere((element) => element.tag == 'STRIPE_NON_EUROPEAN_CARD_FEE')
      .value;
  double idonatioFee =
      feeData.firstWhere((element) => element.tag == 'IDONATIO_FEE').value *
          amount;
  double stripeFixedFee =
      feeData.firstWhere((element) => element.tag == 'STRIPE_FIXED_FEE').value;
  double cardFee = europeanCountries.contains(cardCurrency.toUpperCase())
      ? europeanCardFeePercentage
      : nonEuropeanCardFeePercentage;
  //

  double totalCharge = (amount + idonatioFee + stripeFixedFee) / (1 - cardFee);
  log(amount.toString());
  log(idonatioFee.toString());
  log(stripeFixedFee.toString());
  log(cardFee.toString());
  double onlyCharges = totalCharge - amount;
  var spliteCharge = onlyCharges.toString().split('.');
  // onlyCharges.
  return onlyCharges;
}

double getTotalFee(double charges, amount) {
  return charges + amount;
}
