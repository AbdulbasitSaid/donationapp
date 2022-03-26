import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_process_entity.dart';

part 'donation_process_state.dart';

class DonationProcessCubit extends Cubit<DonationProcessEntity> {
  DonationProcessCubit()
      : super(DonationProcessEntity(
            cartAmount: 0,
            amount: 0,
            applyGiftAidToDonation: false,
            cardLastFourDigits: '',
            cardType: '',
            currency: '',
            donationDetails: [],
            donationLocation: '',
            donationMethod: '',
            doneeId: '',
            expiryMonth: 0,
            expiryYear: 0,
            giftAidEnabled: false,
            idonatoiFee: 0,
            isAnonymous: false,
            paidTransactionFee: false,
            saveDonee: false,
            stripeConnectedAccountId: '',
            stripeFee: 0,
            stripePaymentMethodId: '',
            totalCharges: 0,
            cardCountry: '',
            feedata: []));
  void updateDonationProccess(
      DonationProcessEntity donationProcessEntity) async {
    log(donationProcessEntity.toString());
    emit(donationProcessEntity);
  }
}
