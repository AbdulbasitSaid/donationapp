import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/enable_gift_aid_for_new_donation.dart';
import 'package:idonatio/presentation/journeys/new_donation/review_and_payment.dart';
import 'package:idonatio/presentation/journeys/user/cubit/get_authenticated_user_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../common/stripe_charges_calculations.dart';
import '../../widgets/cards/cart_item_widget.dart';
import '../../widgets/cards/detail_card_for_organisation_widget.dart';
import '../../widgets/cards/include_transaction_fee_widget.dart';
import '../../widgets/dialogs/donation_cart_dialog_content_widget.dart';
import 'entities/donation_item_entity.dart';
import 'entities/donation_process_entity.dart';

class DonationDetialsScreen extends StatefulWidget {
  const DonationDetialsScreen(
      {Key? key,
      required this.isEnableGiftAid,
      required this.isDonateAnonymously})
      : super(key: key);
  final bool isEnableGiftAid, isDonateAnonymously;
  @override
  State<DonationDetialsScreen> createState() => _DonationDetialsScreenState();
}

class _DonationDetialsScreenState extends State<DonationDetialsScreen> {
  bool? isApplyGiftAid = false;
  bool? isDonateAnonymously = false;

  @override
  void initState() {
    context.read<GetDonationFeesCubit>().getFees();
    isDonateAnonymously = widget.isDonateAnonymously;
    isApplyGiftAid = widget.isEnableGiftAid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.read<DonationCartCubit>().emptyCart();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: AppColor.appBackground,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24,
                    ),
                    child:
                        Level2Headline(text: 'Donation details'.toUpperCase()),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Level6Headline(text: 'Donating to:'),
                  ),
                  // Donee Detail card
                  BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                    builder: (context, state) {
                      if (state is GetdoneebycodeSuccess) {
                        if (state.doneeResponseData.organization?.id != null) {
                          return DetailCardForOrganisationWidget(
                            address: state.doneeResponseData.organization
                                    ?.addressLine_1 ??
                                'has no address',
                            id: state.doneeResponseData.doneeCode,
                            name: state.doneeResponseData.organization?.name,
                          );
                        } else {
                          return DetailCardForIndividualWidget(
                            id: state.doneeResponseData.doneeCode,
                            name: state.doneeResponseData.fullName,
                            address: state.doneeResponseData.addressLine_1,
                          );
                        }
                      } else if (state is GetdoneebycodeLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(child: Text('failed to get donee'));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // add/edit Ui
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Level6Headline(text: 'Donation type and amount'),
                        BlocBuilder<DonationCartCubit,
                            List<DonationItemEntity>>(
                          builder: (context, state) {
                            if (state.isNotEmpty) {
                              return TextButton(
                                  onPressed: () {
                                    showDonationCartDialoge(context);
                                  },
                                  child: Text('add/edit'.toUpperCase()));
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                    builder: (context, cartState) {
                      if (cartState.isEmpty) {
                        return TextButton(
                          onPressed: () {
                            showDonationCartDialoge(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: const [
                                Icon(Icons.add),
                                SizedBox(
                                  width: 32,
                                ),
                                Text('Add donation type')
                              ],
                            ),
                          ),
                        );
                      } else if (cartState.isNotEmpty) {
                        double amount = cartState
                            .map((e) => e.amount)
                            .toList()
                            .reduce((a, b) => a + b);

                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Column(
                                  children: cartState
                                      .map((e) => CartItemWdiget(
                                            e,
                                            key: Key(e.id),
                                          ))
                                      .toList()),
                              const Divider(),
                              const IncludeTransactionFeeWidget(),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: BlocBuilder<DonationProcessCubit,
                                        DonationProcessEntity>(
                                    builder: (context, donationProcessState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.text90Primary,
                                                fontSize: 16),
                                      ),
                                      Builder(builder: (context) {
                                        final doneeState = context
                                            .watch<GetdoneebycodeCubit>()
                                            .state;
                                        final paymentMethodState = context
                                            .watch<GetPaymentMethodsCubit>()
                                            .state;
                                        final feeDataState = context
                                            .watch<GetDonationFeesCubit>()
                                            .state;
                                        //
                                        if (doneeState
                                                is GetdoneebycodeSuccess &&
                                            paymentMethodState
                                                is GetPaymentMethodsSuccessful &&
                                            feeDataState
                                                is GetDonationFeesSuccess) {
                                          return Text(getCurrencySymbol(
                                                  '${doneeState.doneeResponseData.country.currencyCode}',
                                                  context) +
                                              (donationProcessState
                                                          .paidTransactionFee
                                                      ? getCharges(
                                                          amount: amount,
                                                          cardCurrency:
                                                              paymentMethodState
                                                                  .paymentMethods
                                                                  .data
                                                                  .first
                                                                  .country,
                                                          feeData: feeDataState
                                                              .feesModel.data,
                                                        ).totalPayment
                                                      : amount)
                                                  .toStringAsFixed(2));
                                        } else {
                                          return const Text('loading');
                                        }
                                      })
                                    ],
                                  );
                                }),
                              )
                            ],
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
// donation options
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Level6Headline(text: 'Donation options'),
                  ),
                  BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            //enabling gift aid
                            TextButton(
                              onPressed: () => context
                                  .read<DonationProcessCubit>()
                                  .updateDonationProccess(state.copyWith(
                                    applyGiftAidToDonation:
                                        !state.applyGiftAidToDonation,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: isApplyGiftAid,
                                      onChanged: (onChanged) {
                                        setState(() {
                                          if (onChanged == false) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (builder) => AlertDialog(
                                                          title: const Text(
                                                              'Disable GiftAid for this donation?'),
                                                          content: const Text(
                                                            'When you disable GiftAid on an eligible donation your donee will be unable to claim an additional 25% on the value of your donation.If you are a tax paying UK resident, this is at no extra cost to you.',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  isApplyGiftAid =
                                                                      onChanged;
                                                                  context
                                                                      .read<
                                                                          DonationProcessCubit>()
                                                                      .updateDonationProccess(state.copyWith(
                                                                          applyGiftAidToDonation:
                                                                              isApplyGiftAid));
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'Disable GiftAid'
                                                                      .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel'
                                                                      .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                          ],
                                                        ));
                                          } else {
                                            isApplyGiftAid = onChanged;
                                            context
                                                .read<DonationProcessCubit>()
                                                .updateDonationProccess(
                                                    state.copyWith(
                                                        applyGiftAidToDonation:
                                                            isApplyGiftAid));
                                          }
                                        });
                                      }),
                                  Flexible(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enable GiftAid on this donation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Your donee gets an additional 25% on your donation – at no extra cost to you.',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            //todo make this selection start from user details
                            // toggle donate anonymously
                            TextButton(
                              onPressed: () {
                                context
                                    .read<DonationProcessCubit>()
                                    .updateDonationProccess(state.copyWith(
                                        isAnonymous: !state.isAnonymous));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: isDonateAnonymously,
                                      onChanged: (onChanged) {
                                        setState(() {
                                          if (onChanged == false) {
                                            showDialog(
                                              context: context,
                                              builder: (builder) => AlertDialog(
                                                title: const Text(
                                                    'Anonymous donations'),
                                                content: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .3,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: const [
                                                        Text(
                                                            'When you choose to make an anonymous donation your personal information is not visible to the donee within the iDonatio platform. '),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                            'However, a donee may still be able to identify you as a donor in certain limited situations — for example, when the donee manually generates an export of donations for their GiftAid claims.'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        isDonateAnonymously =
                                                            onChanged;
                                                        context
                                                            .read<
                                                                DonationProcessCubit>()
                                                            .updateDonationProccess(
                                                                state.copyWith(
                                                              isAnonymous:
                                                                  isDonateAnonymously,
                                                            ));
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Ok'.toUpperCase(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            );
                                          } else {
                                            isDonateAnonymously = onChanged;

                                            context
                                                .read<DonationProcessCubit>()
                                                .updateDonationProccess(
                                                    state.copyWith(
                                                  isAnonymous:
                                                      isDonateAnonymously,
                                                ));
                                          }
                                        });
                                      }),
                                  Flexible(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Donate anonymously',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Your donee may still be able to identify you as a donor in certain situations. Learn more', //ToDo make learn more selectable
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Builder(builder: (context) {
                    // DonationCartCubit
                    final donationCartState =
                        context.watch<DonationCartCubit>().state;
                    // DonationProcessCubit
                    final donationProcessState =
                        context.watch<DonationProcessCubit>().state;
                    // GetdoneebycodeCubit
                    final getDoneeByCodeState =
                        context.watch<GetdoneebycodeCubit>().state;
                    // getfee
                    final getFeeData =
                        context.watch<GetDonationFeesCubit>().state;
                    final getPaymentMethod =
                        context.watch<GetPaymentMethodsCubit>().state;
                    //getting userstate
                    final userState = context.watch<UserCubit>().state;
                    // getting authenticated user
                    final authenticatedUserState =
                        context.watch<GetAuthenticatedUserCubit>().state;
                    double donationCartTotal = donationCartState.isEmpty
                        ? 0
                        : donationCartState
                            .map((e) => e.amount)
                            .toList()
                            .reduce((a, b) => a + b);
                    bool invalidDonationTypes =
                        donationCartState.map((e) => e.amount).contains(0);
                    return authenticatedUserState is GetAuthenticatedUserLoading
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * .6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('getting user detail please wait...'),
                                CircularProgressIndicator.adaptive(),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                if (getDoneeByCodeState
                                        is GetdoneebycodeSuccess &&
                                    getFeeData is GetDonationFeesSuccess &&
                                    getPaymentMethod
                                        is GetPaymentMethodsSuccessful) {
                                  return ElevatedButton(
                                      onPressed: invalidDonationTypes ||
                                              donationCartTotal < 1
                                          ? null
                                          : () {
                                              log(donationCartTotal.toString());

                                              context
                                                  .read<DonationProcessCubit>()
                                                  .updateDonationProccess(donationProcessState
                                                      .copyWith(
                                                          isAnonymous:
                                                              isDonateAnonymously,
                                                          applyGiftAidToDonation:
                                                              isApplyGiftAid,
                                                          giftAidEnabled: authenticatedUserState
                                                                  is GetAuthenticatedUserSuccess
                                                              ? authenticatedUserState
                                                                  .getAuthenticatedUserModel
                                                                  .data
                                                                  .user
                                                                  .donor
                                                                  .giftAidEnabled
                                                              : userState
                                                                      is Authenticated
                                                                  ? userState
                                                                      .userData
                                                                      .user
                                                                      .donor
                                                                      .giftAidEnabled
                                                                  : false,
                                                          stripeConnectedAccountId: getDoneeByCodeState
                                                              .doneeResponseData
                                                              .stripeConnectedAccountId,
                                                          doneeId: getDoneeByCodeState
                                                              .doneeResponseData
                                                              .id,
                                                          feedata: getFeeData
                                                              .feesModel.data,
                                                          currency: getDoneeByCodeState
                                                              .doneeResponseData
                                                              .currency,
                                                          cartAmount:
                                                              donationCartTotal,
                                                          amount: donationProcessState
                                                                  .paidTransactionFee
                                                              ? getCharges(feeData: getFeeData.feesModel.data, cardCurrency: getPaymentMethod.paymentMethods.data.first.country, amount: donationCartTotal)
                                                                  .totalPayment
                                                              : donationCartTotal,
                                                          stripeFee: getCharges(feeData: getFeeData.feesModel.data, cardCurrency: getPaymentMethod.paymentMethods.data.first.country, amount: donationCartTotal).stripeFee,
                                                          idonatoiFee: getCharges(feeData: getFeeData.feesModel.data, cardCurrency: getPaymentMethod.paymentMethods.data.first.country, amount: donationCartTotal).idonationFee,
                                                          totalCharges: getCharges(feeData: getFeeData.feesModel.data, cardCurrency: getPaymentMethod.paymentMethods.data.first.country, amount: donationCartTotal).totalFee,
                                                          totalFee: getCharges(feeData: getFeeData.feesModel.data, cardCurrency: getPaymentMethod.paymentMethods.data.first.country, amount: donationCartTotal).totalFee,
                                                          donationDetails: [
                                                        ...donationCartState.map((e) =>
                                                            DonationProcessDetail(
                                                                amount:
                                                                    e.amount,
                                                                donationTypeId:
                                                                    e.id))
                                                      ]));
                                              Navigator.push(
                                                  context,
                                                  authenticatedUserState
                                                          is GetAuthenticatedUserSuccess
                                                      ? AppRouter.routeToPage(authenticatedUserState
                                                                  .getAuthenticatedUserModel
                                                                  .data
                                                                  .user
                                                                  .donor
                                                                  .giftAidEnabled ==
                                                              true
                                                          ? const ReviewAndPayment()
                                                          : authenticatedUserState
                                                                          .getAuthenticatedUserModel
                                                                          .data
                                                                          .user
                                                                          .donor
                                                                          .giftAidEnabled ==
                                                                      false &&
                                                                  donationProcessState
                                                                          .applyGiftAidToDonation ==
                                                                      false
                                                              ? const ReviewAndPayment()
                                                              : const EnableGiftAidForDonation())
                                                      : userState
                                                              is Authenticated
                                                          ? AppRouter.routeToPage(userState
                                                                      .userData
                                                                      .user
                                                                      .donor
                                                                      .giftAidEnabled ==
                                                                  true
                                                              ? const ReviewAndPayment()
                                                              : userState.userData.user.donor.giftAidEnabled ==
                                                                          false &&
                                                                      donationProcessState.applyGiftAidToDonation ==
                                                                          false
                                                                  ? const ReviewAndPayment()
                                                                  : const EnableGiftAidForDonation())
                                                          : AppRouter.routeToPage(
                                                              const EnableGiftAidForDonation()));
                                            },
                                      child: Text('continue'.toUpperCase()));
                                }
                                return ElevatedButton(
                                    onPressed: null,
                                    child: Text('continue'.toUpperCase()));
                              })
                            ],
                          );
                  }),
                  const SizedBox(
                    height: 56,
                  ),
                ],
              ),
            )));
  }

  Future<dynamic> showDonationCartDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              scrollable: true,
              title: const Level4Headline(
                text: 'Add donation type',
              ),
              content: const DonationCartDialogContent(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('cancle'.toUpperCase()),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Ok');
                  },
                  child: Text('ok'.toUpperCase()),
                ),
              ],
            ));
  }
}
