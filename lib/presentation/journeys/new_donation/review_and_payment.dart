import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/data/models/user_models/payment_method_model.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/makedonation_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/select_payment_method_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/donation_details.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_item_entity.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_process_entity.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/make_donation_entity.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import 'donation_success_screen.dart';

class ReviewAndPayment extends StatefulWidget {
  const ReviewAndPayment({Key? key}) : super(key: key);

  @override
  State<ReviewAndPayment> createState() => _ReviewAndPaymentState();
}

class _ReviewAndPaymentState extends State<ReviewAndPayment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Level2Headline(text: 'Review and payment'),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Level6Headline(text: 'Donation summary'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              AppRouter.routeToPage(
                                  const DonationDetialsScreen()),
                              (route) => false);
                        },
                        child: Text('edit'.toUpperCase())),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //top
                    Text(
                      'Donation to:',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //todo refractor to types of donees
                    BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                      builder: (context, state) {
                        if (state is GetdoneebycodeSuccess) {
                          var name =
                              state.doneeResponseData.organization?.id == null
                                  ? state.doneeResponseData.firstName +
                                      " " +
                                      state.doneeResponseData.lastName
                                  : state.doneeResponseData.organization?.name;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DoneeAvatarPlaceHolder(),
                              const SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$name'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    state.doneeResponseData.addressLine_1
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'donee id${state.doneeResponseData.id}'
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                Icons.verified,
                                color: AppColor.baseSecondaryGreen,
                              ),
                            ],
                          );
                        } else {
                          return const Level2Headline(
                            text: "error getting donee",
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    //donations
                    BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                      builder: (context, donationProcessState) {
                        var isAnonnymous =
                            donationProcessState.isAnonymous ? 'yes' : 'no';
                        var isGiftAid =
                            donationProcessState.giftAidEnabled ? 'yes' : 'no';

                        return BlocBuilder<DonationCartCubit,
                            List<DonationItemEntity>>(
                          builder: (context, state) {
                            double includeFees = donationProcessState
                                        .paidTransactionFee &&
                                    state.isNotEmpty
                                ? getCharge(
                                    state.map((e) => e.amount).toList().reduce(
                                        (value, element) => element + value),
                                    donationProcessState.currency)
                                : 0.0;
                            return Column(children: [
                              ...state
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .7,
                                                child: Text(e.type)),
                                            BlocBuilder<GetdoneebycodeCubit,
                                                GetdoneebycodeState>(
                                              builder: (context, state) {
                                                if (state
                                                    is GetdoneebycodeSuccess) {
                                                  return Text(getCurrencySymbol(
                                                          '${state.doneeResponseData.country.currencyCode}',
                                                          context) +
                                                      e.amount
                                                          .toStringAsFixed(2));
                                                }
                                                return Text(getCurrencySymbol(
                                                        'gbp', context) +
                                                    e.amount
                                                        .toStringAsFixed(2));
                                              },
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Included transaction fee'),
                                    BlocBuilder<GetdoneebycodeCubit,
                                        GetdoneebycodeState>(
                                      builder: (context, state) {
                                        if (state is GetdoneebycodeSuccess) {
                                          return Text(getCurrencySymbol(
                                                  getCurrencySymbol(
                                                      '${state.doneeResponseData.country.currencyCode}',
                                                      context),
                                                  context) +
                                              includeFees.toStringAsFixed(2));
                                        }
                                        return Text(
                                            getCurrencySymbol('gpb', context) +
                                                includeFees.toStringAsFixed(2));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Anonymous donation?'),
                                    Text(isAnonnymous),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('GiftAid enabled?'),
                                    Text(isGiftAid),
                                  ],
                                ),
                              ),
                            ]);
                          },
                        );
                      },
                    ),
                    const Divider(),
                    //total
                    BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                      builder: (context, processState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Level4Headline(text: 'Total to pay'),
                            BlocBuilder<DonationCartCubit,
                                List<DonationItemEntity>>(
                              builder: (context, state) {
                                double amount = state.isEmpty
                                    ? 0.0
                                    : state
                                        .map((e) => e.amount)
                                        .toList()
                                        .reduce((a, b) => a + b);
                                var total =
                                    getCharge(amount, processState.currency) +
                                        amount;
                                return BlocBuilder<GetdoneebycodeCubit,
                                    GetdoneebycodeState>(
                                  builder: (context, state) {
                                    if (state is GetdoneebycodeSuccess) {
                                      return Level4Headline(
                                          text: getCurrencySymbol(
                                                  '${state.doneeResponseData.country.currencyCode}',
                                                  context) +
                                              total.toStringAsFixed(2));
                                    }
                                    return Level4Headline(
                                        text:
                                            getCurrencySymbol('gbp', context) +
                                                total.toStringAsFixed(2));
                                  },
                                );
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Level4Headline(text: 'Your payment method'),
              ),
              const SelectPaymentCardWidget(),
              const SizedBox(
                height: 32,
              ),
              BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                builder: (context, cartState) {
                  return BlocBuilder<GetPaymentMethodsCubit,
                      GetPaymentMethodsState>(
                    builder: (context, payState) {
                      if (payState is GetPaymentMethodsSuccessful) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<DonationProcessCubit,
                                DonationProcessEntity>(
                              builder: (context, state) {
                                return BlocBuilder<SelectPaymentMethodCubit,
                                    PaymentMethodDatum?>(
                                  builder: (context, selectPaymentMethodState) {
                                    return BlocConsumer<MakedonationCubit,
                                        MakedonationState>(
                                      listener: (context, makdeDonataionState) {
                                        if (makdeDonataionState
                                            is MakedonationSuccess) {
                                          Fluttertoast.showToast(
                                              msg: 'Donation Success!!');
                                          context
                                              .read<GetRecentdoneesCubit>()
                                              .getRecentDonees();
                                          context
                                              .read<GetSavedDoneesCubit>()
                                              .getSavedDonee();
                                          context
                                              .read<DonationHistoryCubit>()
                                              .getDonationHistory();
                                          Navigator.push(
                                              context,
                                              AppRouter.routeToPage(
                                                  const DonationSuccessScreen()));
                                        } else if (makdeDonataionState
                                            is MakedonationFailed) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Error trying make Donation');
                                        }
                                      },
                                      builder: (context, makdeDonataionState) {
                                        if (makdeDonataionState
                                            is MakedonationLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'About to make a donation'),
                                                      content: Text(
                                                          'You are about to make donation. your card will charged a total sum of ${getCurrencySymbol(state.currency, context)}${state.amount + state.idonatoiFee}'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              context.read<MakedonationCubit>().makeDonation(
                                                                  MakeDonationEntity(
                                                                          doneeId: state
                                                                              .doneeId,
                                                                          paidTransactionFee: state
                                                                              .paidTransactionFee,
                                                                          donationMethod:
                                                                              'card',
                                                                          donationLocation: state
                                                                              .donationLocation,
                                                                          isAnonymous: state
                                                                              .isAnonymous,
                                                                          applyGiftAidToDonation: state
                                                                              .applyGiftAidToDonation,
                                                                          giftAidEnabled: state
                                                                              .giftAidEnabled,
                                                                          currency: state
                                                                              .currency,
                                                                          cardLastFourDigits: selectPaymentMethodState!
                                                                              .cardLastFourDigits,
                                                                          cardType: selectPaymentMethodState
                                                                              .brand,
                                                                          expiryMonth: selectPaymentMethodState
                                                                              .expMonth,
                                                                          expiryYear: selectPaymentMethodState
                                                                              .expYear,
                                                                          saveDonee: state
                                                                              .saveDonee,
                                                                          donationDetails: [
                                                                            ...cartState.map((e) =>
                                                                                DonationDetail(donationTypeId: e.id, amount: e.amount))
                                                                          ],
                                                                          amount: cartState
                                                                              .map((e) =>
                                                                                  e.amount +
                                                                                  getCharge(
                                                                                    e.amount,
                                                                                    state.currency,
                                                                                  ))
                                                                              .toList()
                                                                              .reduce((a, b) => a + b),
                                                                          stripeConnectedAccountId: state.stripeConnectedAccountId,
                                                                          stripePaymentMethodId: selectPaymentMethodState.id,
                                                                          idonatioTransactionFee: cartState.map((e) => e.amount).toList().reduce((a, b) => a + b) * .03,
                                                                          stripTransactionFee: stripeRatio(state.currency))
                                                                      .toMap());
                                                            },
                                                            child: Text('yes'
                                                                .toUpperCase())),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('no'
                                                                .toUpperCase()))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text('Complete Donation'
                                                .toUpperCase()),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      } else if (payState is GetPaymentMethodsLoading) {
                        return const Center(child: Text('Please wait...'));
                      } else {
                        return const Level2Headline(
                            text: 'error getting payment method');
                      }
                    },
                  );
                },
              ),
              //todo handle payment menthod
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            if (state is GetPaymentMethodsSuccessful) {
              context
                  .read<SelectPaymentMethodCubit>()
                  .selectPaymentMethod(state.paymentMethods.data.first);
              return BlocBuilder<SelectPaymentMethodCubit, PaymentMethodDatum?>(
                builder: (context, selectedPyamentMethodState) {
                  return Row(
                    children: [
                      //selected
                      ...state.paymentMethods.data.map(
                        (e) => TextButton(
                          onPressed: () => context
                              .read<SelectPaymentMethodCubit>()
                              .selectPaymentMethod(e),
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
                                      width: MediaQuery.of(context).size.width *
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
                                                  color:
                                                      const Color(0xff191E6F)),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border:
                                              e == selectedPyamentMethodState
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
                                              padding: const EdgeInsets.all(4),
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
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
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
                        ),
                      ),
                    ],
                  );
                },
              );
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
