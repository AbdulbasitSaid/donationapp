import 'donee_model.dart';

class DonationData {
  String? id;
  String? donorId;
  String? doneeId;
  bool? paidTransactionFee;
  int? idonatioTransactionFee;
  int? stripeTransactionFee;
  String? donationMethod;
  String? disputeStatus;
  String? donationLocation;
  String? currency;
  bool? isAnonymous;
  bool? applyGiftAidToDonation;
  bool? isPlateDonation;
  String? stripePaymentMethodId;
  String? cardLastFourDigits;
  String? cardType;
  String? expiryMonth;
  String? expiryYear;
  String? createdAt;
  Donee? donee;

  DonationData(
      {this.id,
      this.donorId,
      this.doneeId,
      this.paidTransactionFee,
      this.idonatioTransactionFee,
      this.stripeTransactionFee,
      this.donationMethod,
      this.disputeStatus,
      this.donationLocation,
      this.currency,
      this.isAnonymous,
      this.applyGiftAidToDonation,
      this.isPlateDonation,
      this.stripePaymentMethodId,
      this.cardLastFourDigits,
      this.cardType,
      this.expiryMonth,
      this.expiryYear,
      this.createdAt,
      this.donee});

  DonationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    donorId = json['donor_id'];
    doneeId = json['donee_id'];
    paidTransactionFee = json['paid_transaction_fee'];
    idonatioTransactionFee = json['idonatio_transaction_fee'];
    stripeTransactionFee = json['stripe_transaction_fee'];
    donationMethod = json['donation_method'];
    disputeStatus = json['dispute_status'];
    donationLocation = json['donation_location'];
    currency = json['currency'];
    isAnonymous = json['is_anonymous'];
    applyGiftAidToDonation = json['apply_gift_aid_to_donation'];
    isPlateDonation = json['is_plate_donation'];
    stripePaymentMethodId = json['stripe_payment_method_id'];
    cardLastFourDigits = json['card_last_four_digits'];
    cardType = json['card_type'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    createdAt = json['created_at'];
    donee = json['donee'] != null ? Donee.fromJson(json['donee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['donor_id'] = donorId;
    data['donee_id'] = doneeId;
    data['paid_transaction_fee'] = paidTransactionFee;
    data['idonatio_transaction_fee'] = idonatioTransactionFee;
    data['stripe_transaction_fee'] = stripeTransactionFee;
    data['donation_method'] = donationMethod;
    data['dispute_status'] = disputeStatus;
    data['donation_location'] = donationLocation;
    data['currency'] = currency;
    data['is_anonymous'] = isAnonymous;
    data['apply_gift_aid_to_donation'] = applyGiftAidToDonation;
    data['is_plate_donation'] = isPlateDonation;
    data['stripe_payment_method_id'] = stripePaymentMethodId;
    data['card_last_four_digits'] = cardLastFourDigits;
    data['card_type'] = cardType;
    data['expiry_month'] = expiryMonth;
    data['expiry_year'] = expiryYear;
    data['created_at'] = createdAt;
    if (donee != null) {
      data['donee'] = donee!.toJson();
    }
    return data;
  }
}