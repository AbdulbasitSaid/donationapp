import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/stripe_charges_calculations.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';

import '../../../data/models/user_models/payment_method_model.dart';
import '../../journeys/new_donation/cubit/donation_process_cubit.dart';
import '../../journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import '../../journeys/new_donation/cubit/select_payment_method_cubit.dart';
import '../../themes/app_color.dart';
import '../labels/level_2_heading.dart';
import '../labels/level_4_headline.dart';

class SelectPaymentCardWidget extends StatelessWidget {
  const SelectPaymentCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      height: MediaQuery.of(context).size.height * .25,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<GetPaymentMethodsCubit, GetPaymentMethodsState>(
          builder: (context, state) {
            if (state is GetPaymentMethodsSuccessful &&
                state.paymentMethods.data.isNotEmpty) {
              context
                  .read<SelectPaymentMethodCubit>()
                  .selectPaymentMethod(state.paymentMethods.data.first);
              return BlocBuilder<SelectPaymentMethodCubit, PaymentMethodDatum?>(
                builder: (context, selectedPyamentMethodState) {
                  final donationProcessState =
                      context.watch<DonationProcessCubit>().state;
                  final donationCartState =
                      context.watch<DonationCartCubit>().state;
                  double cartTotal = donationCartState.isEmpty
                      ? 0
                      : donationCartState
                          .map((e) => e.amount)
                          .toList()
                          .reduce((value, element) => value + element);
                  return Row(
                    children: [
                      //selected
                      ...state.paymentMethods.data.map(
                        (e) {
                          return TextButton(
                            onPressed: () {
                              if (!europeanCountries.contains(e.country) &&
                                  donationProcessState.totalFee > 0) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'About to change your card'),
                                        content: Text(
                                            'You are about to switch to a none European card your new charge will be: £${getCharges(feeData: donationProcessState.feedata, cardCurrency: e.country, amount: cartTotal).totalFee} '),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<
                                                        DonationProcessCubit>()
                                                    .updateDonationProccess(
                                                      donationProcessState
                                                          .copyWith(
                                                        cardLastFourDigits: e
                                                            .cardLastFourDigits,
                                                        cardType: e.brand,
                                                        expiryMonth: e.expMonth,
                                                        expiryYear: e.expYear,
                                                        idonatoiFee: getCharges(
                                                                feeData:
                                                                    donationProcessState
                                                                        .feedata,
                                                                cardCurrency:
                                                                    e.country,
                                                                amount:
                                                                    cartTotal)
                                                            .idonationFee,
                                                        totalCharges: donationProcessState
                                                                .paidTransactionFee
                                                            ? getCharges(
                                                                    feeData:
                                                                        donationProcessState
                                                                            .feedata,
                                                                    cardCurrency: e
                                                                        .country,
                                                                    amount:
                                                                        cartTotal)
                                                                .totalFee
                                                            : 0,
                                                        totalFee: donationProcessState
                                                                .paidTransactionFee
                                                            ? getCharges(
                                                                    feeData:
                                                                        donationProcessState
                                                                            .feedata,
                                                                    cardCurrency: e
                                                                        .country,
                                                                    amount:
                                                                        cartTotal)
                                                                .totalFee
                                                            : 0,
                                                        cardCountry: e.country,
                                                        amount: donationProcessState
                                                                .paidTransactionFee
                                                            ? cartTotal +
                                                                getCharges(
                                                                        feeData:
                                                                            donationProcessState
                                                                                .feedata,
                                                                        cardCurrency: e
                                                                            .country,
                                                                        amount:
                                                                            cartTotal)
                                                                    .totalFee
                                                            : cartTotal,
                                                      ),
                                                    );
                                                context
                                                    .read<
                                                        SelectPaymentMethodCubit>()
                                                    .selectPaymentMethod(e);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('CANCEL'))
                                        ],
                                      );
                                    });
                              } else {
                                context
                                    .read<DonationProcessCubit>()
                                    .updateDonationProccess(
                                      donationProcessState.copyWith(
                                        cardLastFourDigits:
                                            e.cardLastFourDigits,
                                        cardType: e.brand,
                                        expiryMonth: e.expMonth,
                                        expiryYear: e.expYear,
                                        idonatoiFee: getCharges(
                                                feeData: donationProcessState
                                                    .feedata,
                                                cardCurrency: e.country,
                                                amount: cartTotal)
                                            .idonationFee,
                                        totalCharges: donationProcessState
                                                .paidTransactionFee
                                            ? getCharges(
                                                    feeData:
                                                        donationProcessState
                                                            .feedata,
                                                    cardCurrency: e.country,
                                                    amount: cartTotal)
                                                .totalFee
                                            : 0,
                                        totalFee: donationProcessState
                                                .paidTransactionFee
                                            ? getCharges(
                                                    feeData:
                                                        donationProcessState
                                                            .feedata,
                                                    cardCurrency: e.country,
                                                    amount: cartTotal)
                                                .totalFee
                                            : 0,
                                        cardCountry: e.country,
                                        amount: donationProcessState
                                                .paidTransactionFee
                                            ? cartTotal +
                                                getCharges(
                                                        feeData:
                                                            donationProcessState
                                                                .feedata,
                                                        cardCurrency: e.country,
                                                        amount: cartTotal)
                                                    .totalFee
                                            : cartTotal,
                                      ),
                                    );
                                context
                                    .read<SelectPaymentMethodCubit>()
                                    .selectPaymentMethod(e);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            e.brand.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                        0xff191E6F)),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            border: e ==
                                                    selectedPyamentMethodState
                                                ? Border.all(
                                                    color: AppColor
                                                        .baseSecondaryGreen,
                                                    width: 4,
                                                  )
                                                : Border.all(
                                                    style: BorderStyle.none),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0, 10),
                                                  blurRadius: 14,
                                                  spreadRadius: -8,
                                                  color:
                                                      AppColor.border50Primary),
                                            ]),
                                      ),
                                      e == selectedPyamentMethodState
                                          ? Positioned(
                                              bottom: -10,
                                              right: -10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        offset: Offset(0, 10),
                                                        blurRadius: 14,
                                                        spreadRadius: -8,
                                                        color: AppColor
                                                            .border50Primary,
                                                      ),
                                                    ],
                                                    color: AppColor
                                                        .baseSecondaryGreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height))),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Level4Headline(
                                      text: '....${e.cardLastFourDigits}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (state is GetPaymentMethodsSuccessful &&
                state.paymentMethods.data.isEmpty) {
              return const Center(
                  child: Text(
                      'Please Go to manage account to add a payment method'));
            } else if (state is GetPaymentMethodsLoading) {
              return const Center(
                  child: Level4Headline(
                      text: 'Getting payment methods please wait...'));
            } else {
              return const Center(
                  child: Level2Headline(text: 'Error getting payment methods'));
            }
          },
        ),
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
