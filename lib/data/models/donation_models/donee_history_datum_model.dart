import 'package:idonatio/data/models/donation_models/donation_detail_model.dart';
import 'package:idonatio/data/models/donation_models/donee_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donee_history_datum_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class DonationHistoryDatumModel {
  DonationHistoryDatumModel({
    required this.id,
    required this.donationCode,
    required this.donorId,
    required this.doneeId,
    required this.paidTransactionFee,
    required this.idonatioTransactionFee,
    required this.stripeTransactionFee,
    required this.donationMethod,
    required this.stripePaymentIntentId,
    required this.type,
    required this.donationLocation,
    required this.currency,
    required this.isAnonymous,
    required this.applyGiftAidToDonation,
    required this.isPlateDonation,
    required this.channel,
    required this.stripePaymentMethodId,
    required this.hasRefund,
    required this.hasClaimedGiftAid,
    required this.giftAidClaimId,
    required this.cardLastFourDigits,
    required this.cardType,
    required this.expiryMonth,
    required this.expiryYear,
    required this.note,
    required this.createdAt,
    required this.rank,
    required this.donationDetails,
    required this.donee,
  });

  final String id;
  final String donationCode;
  final String donorId;
  final String doneeId;
  final bool paidTransactionFee;
  final double idonatioTransactionFee;
  final double stripeTransactionFee;
  final String donationMethod;
  final String stripePaymentIntentId;
  final dynamic type;
  final String donationLocation;
  final String currency;
  final bool isAnonymous;
  final bool applyGiftAidToDonation;
  final bool isPlateDonation;
  final dynamic channel;
  final String stripePaymentMethodId;
  final bool hasRefund;
  final bool hasClaimedGiftAid;
  final dynamic giftAidClaimId;
  final String cardLastFourDigits;
  final String cardType;
  final String expiryMonth;
  final String expiryYear;
  final dynamic note;
  final DateTime createdAt;
  final int rank;
  final List<DonationDetailModel> donationDetails;
  final DoneeModel donee;

  factory DonationHistoryDatumModel.fromJson(json) =>
      _$DonationHistoryDatumModelFromJson(json);

  get totalPayment => {
        paidTransactionFee == true
            ? stripeTransactionFee +
                idonatioTransactionFee +
                donationDetails
                    .map((e) => e.amount)
                    .toList()
                    .reduce((value, element) => value + element)
            : donationDetails
                .map((e) => e.amount)
                .toList()
                .reduce((value, element) => value + element),
      };

  double get transationFee => paidTransactionFee == true
      ? stripeTransactionFee + idonatioTransactionFee
      : 0.0;
  Map<String, dynamic> toJson() => _$DonationHistoryDatumModelToJson(this);
}
