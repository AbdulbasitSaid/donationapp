
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
      ? amount * europeanCardFeePercentage
      : amount * nonEuropeanCardFeePercentage;
  //
  double totalCharge = (amount + idonatioFee + stripeFixedFee) + cardFee;

  double charges = totalCharge - amount;
  var spliteCharge = charges.toString().split('.');
  var left = spliteCharge[0];
  var right = spliteCharge[1].split('');
  String stringCharg =
      left + '.' + (right.length > 1 ? right.take(2).join() : right.first);
  // charges = double.parse(stringCharg);
  // onlyCharges.
  var totalPaySplit =
      ((double.parse(stringCharg)) + (amount)).toString().split('.');
  var totalPayLeft = totalPaySplit[0];
  var totalPayRight = totalPaySplit[1];
  String totalPayment = totalPayLeft + '.' + totalPayRight;
  double totalPaymentResult = double.parse(totalPayment);
  //
  return amount == 0
      ? ChargesResult(
          stripeFee: 0.0,
          totalFee: 0.0,
          idonationFee: 0.0,
          totalPayment: amount)
      : ChargesResult(
          idonationFee: idonatioFee,
          stripeFee: getStripeTransactionFee(
            donationAmount: amount,
            idonatioFee: idonatioFee,
            totalCharge: double.parse(stringCharg),
          ),
          totalFee: double.parse(stringCharg),
          totalPayment: (double.parse(totalPaymentResult.toStringAsFixed(2))));
}

//
double getIdonatioTransactionFee(
    {required double donationAmount, required double stripeDontionRatio}) {
  return donationAmount == 0 ? 0 : donationAmount * stripeDontionRatio;
}

//
double getStripeTransactionFee({
  required double totalCharge,
  required double idonatioFee,
  required double donationAmount,
}) {
  return donationAmount == 0 ? 0 : totalCharge - idonatioFee;
}

class ChargesResult {
  final double stripeFee;
  final double totalFee;
  final double idonationFee;
  final double totalPayment;

  ChargesResult({
    required this.stripeFee,
    required this.totalFee,
    required this.idonationFee,
    required this.totalPayment,
  });
}
