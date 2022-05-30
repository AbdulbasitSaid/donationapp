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
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_success_entity.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/make_donation_entity.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/buttons/logout_button_widget.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../widgets/cards/select_payment_card_widget.dart';
import '../../widgets/dialogs/app_loader_dialog.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';
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
    final donorState = context.watch<UserCubit>().state;
    final donataionProcessState = context.watch<DonationProcessCubit>().state;
    final getDoneeState = context.watch<GetdoneebycodeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        actions: const [LogoutButton()],
      ),
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
                          Navigator.push(
                            context,
                            AppRouter.routeToPage(DonationDetialsScreen(
                              isDonateAnonymously: donorState is Authenticated
                                  ? donorState
                                      .userData.user.alwaysDonateAnonymosly
                                  : false,
                              isEnableGiftAid: donorState is Authenticated
                                  ? donorState
                                      .userData.user.donor.giftAidEnabled
                                  : false,
                            )),
                          );
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
                          var name = state.doneeResponseData.organization?.id ==
                                  null
                              ? "${state.doneeResponseData.firstName} ${state.doneeResponseData.lastName}"
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
                                    'donee id: ${state.doneeResponseData.doneeCode}'
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

                    Builder(builder: (context) {
                      // DonationProcessCubit
                      final donationProcessState =
                          context.watch<DonationProcessCubit>().state;
                      final doneeState =
                          context.watch<GetdoneebycodeCubit>().state;
                      // DonationCartCubit
                      final donationCartState =
                          context.watch<DonationCartCubit>().state;

                      return Column(children: [
                        ...donationCartState.map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.type),
                                  Text(
                                      '${getCurrencySymbol(doneeState is GetdoneebycodeSuccess ? doneeState.doneeResponseData.currency : 'gpb', context)}${e.amount.toStringAsFixed(2)}')
                                ],
                              ),
                            )),
                        donationProcessState.paidTransactionFee
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Included transaction fee'),
                                    Text(donationProcessState.paidTransactionFee
                                        ? '${getCurrencySymbol(doneeState is GetdoneebycodeSuccess ? doneeState.doneeResponseData.currency : 'gpb', context)}${donationProcessState.totalFee.toStringAsFixed(2)}'
                                        : '${getCurrencySymbol(doneeState is GetdoneebycodeSuccess ? doneeState.doneeResponseData.currency : 'gpb', context)}0.00')
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Anonymous donation?'),
                              Text(donationProcessState.isAnonymous
                                  ? 'Yes'
                                  : 'no')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('GiftAid enabled?'),
                              Text(donationProcessState.applyGiftAidToDonation
                                  ? 'Yes'
                                  : 'no')
                            ],
                          ),
                        ),
                      ]);
                    }),

                    const Divider(),
                    Builder(builder: (context) {
                      // DonationProcessCubit
                      final donationProcessState =
                          context.watch<DonationProcessCubit>().state;

                      final doneeState =
                          context.watch<GetdoneebycodeCubit>().state;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Level4Headline(text: 'Total to pay'),
                          Level4Headline(
                              text:
                                  '${getCurrencySymbol(doneeState is GetdoneebycodeSuccess ? doneeState.doneeResponseData.currency : 'gpb', context)}${donationProcessState.amount.toStringAsFixed(2)}'),
                        ],
                      );
                    })
                    //total
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
                                                  DonationSuccessScreen(
                                                donationSuccessEnitity:
                                                    DonationSuccessEnitity(
                                                  amount: donataionProcessState
                                                      .amount,
                                                  nameOfDonee: getDoneeState
                                                          is GetdoneebycodeSuccess
                                                      ? getDoneeState
                                                          .doneeResponseData
                                                          .fullName
                                                      : '',
                                                  transactionFee:
                                                      donataionProcessState
                                                          .totalFee,
                                                  paidCharges:
                                                      donataionProcessState
                                                          .paidTransactionFee,
                                                ),
                                              )));
                                        } else if (makdeDonataionState
                                            is MakedonationLoading) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AppLoader(
                                                  loadingMessage:
                                                      'Sending request please wait..',
                                                );
                                              });
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
                                            child: PrimaryAppLoader(),
                                          );
                                        } else {
                                          return BlocBuilder<
                                              GetPaymentMethodsCubit,
                                              GetPaymentMethodsState>(
                                            builder:
                                                (context, paymentMethodState) {
                                              if (paymentMethodState
                                                  is GetPaymentMethodsFailed) {
                                                return ElevatedButton(
                                                  onPressed: null,
                                                  child: Text(
                                                      'Complete Donation'
                                                          .toUpperCase()),
                                                );
                                              }
                                              if (paymentMethodState
                                                      is GetPaymentMethodsSuccessful &&
                                                  paymentMethodState
                                                      .paymentMethods
                                                      .data
                                                      .isEmpty) {
                                                return ElevatedButton(
                                                  onPressed: null,
                                                  child: Text(
                                                      'Complete Donation'
                                                          .toUpperCase()),
                                                );
                                              }
                                              return ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (builder) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'About to make a donation'),
                                                          content: Text(
                                                              'You are about to make donation. your card will charged a total sum of ${getCurrencySymbol(state.currency, context)}${state.amount}'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  context
                                                                      .read<
                                                                          MakedonationCubit>()
                                                                      .makeDonation(
                                                                          MakeDonationEntity(
                                                                        channel:
                                                                            'mobile',
                                                                        doneeId:
                                                                            state.doneeId,
                                                                        paidTransactionFee:
                                                                            state.paidTransactionFee,
                                                                        donationMethod:
                                                                            'card',
                                                                        donationLocation:
                                                                            state.donationLocation,
                                                                        isAnonymous:
                                                                            state.isAnonymous,
                                                                        applyGiftAidToDonation:
                                                                            state.applyGiftAidToDonation,
                                                                        giftAidEnabled:
                                                                            state.giftAidEnabled,
                                                                        currency:
                                                                            state.currency,
                                                                        cardLastFourDigits:
                                                                            selectPaymentMethodState!.cardLastFourDigits,
                                                                        cardType:
                                                                            selectPaymentMethodState.brand,
                                                                        expiryMonth:
                                                                            selectPaymentMethodState.expMonth,
                                                                        expiryYear:
                                                                            selectPaymentMethodState.expYear,
                                                                        saveDonee:
                                                                            state.saveDonee,
                                                                        donationDetails: [
                                                                          ...cartState.map((e) => DonationDetail(
                                                                              donationTypeId: e.id,
                                                                              amount: e.amount))
                                                                        ],
                                                                        amount:
                                                                            state.amount,
                                                                        stripeConnectedAccountId:
                                                                            state.stripeConnectedAccountId,
                                                                        stripePaymentMethodId:
                                                                            selectPaymentMethodState.id,
                                                                        idonatioTransactionFee:
                                                                            state.idonatoiFee,
                                                                        stripTransactionFee:
                                                                            state.stripeFee,
                                                                        totalFee:
                                                                            state.totalFee,
                                                                      ).toMap());
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
                                            },
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




//Todo fix Device Change bug